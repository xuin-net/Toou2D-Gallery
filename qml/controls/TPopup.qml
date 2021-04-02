import QtQuick 2.12

QtObject{
    id: popup

    signal closeed();

    signal opened();

    signal hided(var autoclose);

    signal triggeredBackground();

    property Component backgroundComponent;

    property Component layoutComponent;

    property QtObject privatec;

    property bool isOpen: false;

    property real bgOpacity: 0.5

    default property alias childitem: _private.childs;

    function open(){
        if (!isOpen) {
            isOpen = true;
            _private.create();
            opened();
        }
    }

    function hide(autoclose){
        if (isOpen) {
            isOpen = false;
            _private.hide(autoclose);
            hided(autoclose);
        }
    }

    function close(){
        if (isOpen) {
            isOpen = false;
            _private.close();
            closeed();
        }
    }

    function update() {
        _private.create()
    }

    backgroundComponent:  Rectangle{
        color: "BLACK"; z:-1;
        opacity: 0
        Behavior on opacity {
            NumberAnimation {
                duration: 200;
            }
        }
    }

    privatec: QtObject{
        id:_private;

        property list<QtObject> childs;
        property var layout: null;
        function create(){
            if(!layout){
                var parentWindows = typeof(__root_window__) == "object" ? __root_window__ : __splash_window__
                layout = popup.layoutComponent.createObject(parentWindows);
                layout.z = 99999;
            }
            if (typeof(layout.show) == "function") {
                layout.show();
            }

            for(var i in childs){
                if((typeof childs[i].parent) !== "undefined" && (typeof childs[i].className) === "undefined"){
                    childs[i].parent = layout;
                    childs[i].visible = true;
                }
            }
        }

        function hide(autoclose){
            if (layout && typeof(layout.hide) == "function") {
                layout.hide(autoclose);
            }
            if (!autoclose) {
                for(var i in childs){
                    if (childs[i] && (typeof childs[i].parent) !== "undefined")
                        childs[i].visible = false;
                }
            }
        }

        function close(){
            if(layout) {
                layout.destroy();
                layout = null;
            }
        }
    }

    layoutComponent: Component{
        Item{
            id:item
            anchors.fill: parent;

            function show(){
                if(bgloader.item) {
                    mouseArea.visible = true;
                    bgloader.item.opacity = popup.bgOpacity
                }
            }

            function hide(autoclose){
                if(autoclose) {
                    item.visible = false;
                    item.destroy(500);
                }
                if(bgloader.item) {
                    mouseArea.visible = false;
                    bgloader.item.opacity = 0;
                }
            }

            //black bg
            Loader{
                id:bgloader;
                anchors.fill: parent;
                sourceComponent: backgroundComponent;
            }

            MouseArea{
                id: mouseArea
                anchors.fill: parent;
                onClicked: triggeredBackground();
                onWheel: {}
            }

            //push other item
        }
    }
}
