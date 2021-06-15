import QtQuick 2.6
import "../controls" as Controls

Item {
    anchors.fill: parent;

    Controls.TTreeList {
        id: list
        width: 381;height: parent.height

        //firstReject: true;

        onRemoveWithUUID: {
            // 数据删除完成后，刷新列表
            list.removeSelectSyndrome(uuid);
        }

        onRequireListData: {
            // 请求数据完成后，刷新列表
            list.setSelectInfo(requireData)
        }
    }

    Component.onCompleted: {
        var data = [
            {
                "uuid": 1,
                "name": "一级内容1",
                "children": [
                    {
                        "uuid": 4,
                        "name": "二级内容1",
                        "children": [
                            {
                                "uuid": "ba29d889-acd2-441b-8fc4-615e3544d187",
                                "name": "三级内容1"
                            },
                            {
                                "uuid": "91974fc9-a1ae-4f44-ad89-bad264c6666d",
                                "name": "三级内容2"
                            },
                            {
                                "uuid": "a6e761c1-66ce-4ea1-b48f-a0e7ce28727f",
                                "name": "三级内容3"
                            },
                            {
                                "uuid": "00bfeb1d-c69a-4947-b446-6d94eaeab0d8",
                                "name": "三级内容4"
                            },
                        ]
                    },
                    {
                        "uuid": 10,
                        "name": "二级内容2",
                        "children": [
                            {
                                "uuid": "05dffebc-0159-404a-a5e2-924bc92cbcb9",
                                "name": "三级内容1"
                            },
                            {
                                "uuid": "d340d4ca-ebe6-41cb-b39b-7a1b1d030fc8",
                                "name": "三级内容2"
                            },
                            {
                                "uuid": "e12e6140-a133-400c-85bc-8c20efaf7931",
                                "name": "三级内容3"
                            },
                            {
                                "uuid": "a94b1de5-839b-4218-a541-976d0889ad25",
                                "name": "三级内容4"
                            },
                        ]
                    },
                ]
            },
            {
                "uuid": 2,
                "name": "一级内容2",
                "children": [
                    {
                        "uuid": "04fc1935-4acd-4daa-bb43-2e3c0fa94591",
                        "name": "二级内容1"
                    },
                    {
                        "uuid": "9637b142-16b6-401f-8bbc-c49e2f0798c2",
                        "name": "二级内容2"
                    },
                    {
                        "uuid": "50c4a25c-840e-4f1f-aa06-05b9f487967e",
                        "name": "二级内容3"
                    },
                    {
                        "uuid": "e0d0c340-9acf-4913-bf8b-5c02abad86d0",
                        "name": "二级内容4"
                    },
                    {
                        "uuid": "dce74bde-a593-4506-a0d5-0c2206db96d5",
                        "name": "二级内容5"
                    },
                    {
                        "uuid": "d699abbe-ae59-4ce3-b40a-7345695fc087",
                        "name": "二级内容6"
                    }
                ]
            },
            {
                "uuid": 3,
                "name": "一级内容3",
                "children": [
                    {
                        "uuid": "ed29fe05-ddcc-470a-bd02-d1791e141e52",
                        "name": "二级内容1"
                    },
                    {
                        "uuid": "892d07c5-8a46-4d01-a362-7c1e167be9bb",
                        "name": "二级内容2"
                    },
                    {
                        "uuid": "34f03ef4-599f-4bff-ac52-45df3e5251e9",
                        "name": "二级内容3"
                    },
                ]
            }
        ]

        list.updateModel(data)
    }
}
