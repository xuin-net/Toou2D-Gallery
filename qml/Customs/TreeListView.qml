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
                "name": "遗传综合征",
                "children": [
                    {
                        "uuid": 4,
                        "name": "大脑异常为特征",
                        "children": [
                            {
                                "uuid": "ba29d889-acd2-441b-8fc4-615e3544d187",
                                "name": "Meckel-Gruber syndrome"
                            },
                            {
                                "uuid": "91974fc9-a1ae-4f44-ad89-bad264c6666d",
                                "name": "视隔发育不良"
                            },
                            {
                                "uuid": "a6e761c1-66ce-4ea1-b48f-a0e7ce28727f",
                                "name": "无脑回畸形Ⅰ型"
                            },
                            {
                                "uuid": "00bfeb1d-c69a-4947-b446-6d94eaeab0d8",
                                "name": "致死性水胎病"
                            },
                            {
                                "uuid": "cbb1e8fc-f629-4787-a84b-f8c025fb8017",
                                "name": "Neu-Laxova syndrome"
                            },
                            {
                                "uuid": "ea3418e6-e211-4c7c-8527-121d813787b5",
                                "name": "Aicardi syndrome"
                            },
                            {
                                "uuid": "4c72889b-f69f-444d-9d3b-9ea5131bd86c",
                                "name": "X连锁遗传性脑积水"
                            },
                            {
                                "uuid": "7b99fd74-e31d-4079-bf48-2b018fbaf6f7",
                                "name": "无脑回畸形Ⅱ型"
                            },
                            {
                                "uuid": "640f37ae-6c22-4b09-bcee-259d1742db7d",
                                "name": "多发性基底细胞痣综合征"
                            },
                            {
                                "uuid": "710ca464-02b5-41cb-8493-16ef3cee4b70",
                                "name": "Joubert syndrome"
                            },
                            {
                                "uuid": "f4fe0d08-20c8-4753-a4ac-62977fde2640",
                                "name": "小头畸形"
                            }
                        ]
                    },
                    {
                        "uuid": 10,
                        "name": "序列征和并发症",
                        "children": [
                            {
                                "uuid": "05dffebc-0159-404a-a5e2-924bc92cbcb9",
                                "name": "弯刀综合征"
                            },
                            {
                                "uuid": "d340d4ca-ebe6-41cb-b39b-7a1b1d030fc8",
                                "name": "心脾综合征：无脾（右侧异构综合征）"
                            },
                            {
                                "uuid": "e12e6140-a133-400c-85bc-8c20efaf7931",
                                "name": "先天性颈椎融合畸形"
                            },
                            {
                                "uuid": "a94b1de5-839b-4218-a541-976d0889ad25",
                                "name": "10三体综合征"
                            },
                            {
                                "uuid": "bb157c70-39a5-43c2-8d7f-a35b7ba7ffa5",
                                "name": "11p缺失（Jacobsen综合征）"
                            },
                            {
                                "uuid": "069a9494-3c6d-4983-9616-3f0cfcead9c2",
                                "name": "Cantrell 五联症"
                            },
                            {
                                "uuid": "66c161a9-f997-4b5d-88c2-956566c6feef",
                                "name": "羊膜带综合征"
                            },
                            {
                                "uuid": "5ab17d74-0ad2-41a1-9366-4726bc2348b8",
                                "name": "CHARGE综合征"
                            },
                            {
                                "uuid": "1dfa7ffd-0810-4e74-be4a-63f6635fc715",
                                "name": "4p缺失（Wolf- Hirschhorn 综合征）"
                            },
                            {
                                "uuid": "5dfd2922-2d74-49f0-b065-dd4c36569166",
                                "name": "脑-眼-面-骨骼（COFS）综合征"
                            },
                            {
                                "uuid": "9172d0c4-b016-4361-b26e-5009fb70c193",
                                "name": "三倍体综合征"
                            },
                            {
                                "uuid": "c5684c75-b110-4f86-81c2-b878f5577338",
                                "name": "VATER综合征"
                            },
                            {
                                "uuid": "e688d9ab-29fb-4c31-b274-839d35726a83",
                                "name": "眼距宽-尿道下裂综合征"
                            },
                            {
                                "uuid": "bac8d3dd-8f36-4cae-88ac-d7ef7a35a0a1",
                                "name": "关节屈曲症"
                            },
                            {
                                "uuid": "0609a26e-4430-43c7-b7b7-36091c0491ab",
                                "name": "22三体综合征"
                            },
                            {
                                "uuid": "4ff775c2-468d-45b9-898b-87d6cf31710e",
                                "name": "人鱼体序列征（并腿畸形）"
                            },
                            {
                                "uuid": "008acd33-12f3-48cf-b557-f93cf8d98252",
                                "name": "全前脑畸形（无叶）"
                            },
                            {
                                "uuid": "903b2207-763f-4d0c-9fba-704f3fb80a29",
                                "name": "18三体综合征"
                            },
                            {
                                "uuid": "38d8db64-bd0a-4617-b21d-61730337bf46",
                                "name": "12p四体（Pallister Killian综合征）"
                            },
                            {
                                "uuid": "8b937916-9a86-409a-9932-111d6fbbdb36",
                                "name": "先天性高位气道闭锁综合征（CHAOS）"
                            },
                            {
                                "uuid": "45ab193b-81e3-4ef9-92d0-3e901f69fb6e",
                                "name": "5P末端缺失综合征（猫叫综合征）"
                            },
                            {
                                "uuid": "170e19ef-877b-41a5-92ca-fc56c1b19120",
                                "name": "Turner综合征"
                            },
                            {
                                "uuid": "0fced184-001c-4436-b4a6-a7adbf742873",
                                "name": "心脾综合征：多脾（左侧异构综合征）"
                            },
                            {
                                "uuid": "1668b8de-0b1c-4169-8225-f57d76aea873",
                                "name": "DiGeorge综合征（22q11微缺失）"
                            },
                            {
                                "uuid": "2549c5a8-d91a-44d0-b836-f9b7ff72cdaf",
                                "name": "尾部退化综合征"
                            },
                            {
                                "uuid": "b773e661-2e0e-4e93-8154-e8c5f5eb2d1a",
                                "name": "泄殖腔外翻序列"
                            },
                            {
                                "uuid": "8719991b-5af7-4bd8-a0fa-794e0484bb7f",
                                "name": "先天性肾上腺皮质增生症"
                            },
                            {
                                "uuid": "34f2aff2-c283-45df-baae-d5e8809f3362",
                                "name": "苗勒管-肾-颈胸椎发育不良（MURCS 综合征）"
                            },
                            {
                                "uuid": "15f37be9-d3bb-431f-8522-7f324623e9f2",
                                "name": "梅干腹综合征"
                            },
                            {
                                "uuid": "2fb16ab2-626c-4961-914e-1862e0ee40aa",
                                "name": "13三体综合征"
                            },
                            {
                                "uuid": "f0459285-24cf-4b57-8ab6-a1f452b24499",
                                "name": "肾脏缺如（potter综合征）"
                            },
                            {
                                "uuid": "60370154-f47a-44b4-a9a2-d8e76a2ed822",
                                "name": "特发性婴儿型动脉钙化"
                            },
                            {
                                "uuid": "46da2084-64ee-484d-af87-d15466771a2a",
                                "name": "胎儿运动不能序列征"
                            },
                            {
                                "uuid": "7501630c-3433-4212-abcf-e2fc1db0c119",
                                "name": "21三体综合征（唐氏综合征）"
                            },
                            {
                                "uuid": "acacd53e-4d19-4af7-827f-6974389c6e5c",
                                "name": "神经管畸形"
                            },
                            {
                                "uuid": "8b117eef-d7f3-47e0-ae75-1ceafab4623d",
                                "name": "巨膀胱-小结肠-肠蠕动迟缓综合征"
                            },
                            {
                                "uuid": "61a4cb09-406b-4904-8da6-de2b0a536e09",
                                "name": "9三体综合征"
                            }
                        ]
                    },
                    {
                        "uuid": 5,
                        "name": "肢体异常为特征",
                        "children": [
                            {
                                "uuid": "c8bb022e-2ab6-4787-87d9-8f72fb8d24c5",
                                "name": "多发翼状胬肉综合征(致死型)"
                            },
                            {
                                "uuid": "2f2997b5-d7fb-4c10-b5ec-72fa96096c25",
                                "name": "Holt-Oram syndrome"
                            },
                            {
                                "uuid": "426ffc92-386f-424a-9fa2-d4c36b3bffa1",
                                "name": "先天性缺指（趾）-外胚叶发育不全-唇/腭裂综合征"
                            },
                            {
                                "uuid": "ecc52148-5e0a-4b34-a39b-23d2c7285e10",
                                "name": "血小板减少-桡骨缺如综合征(TAR)"
                            },
                            {
                                "uuid": "8676f438-a7ac-4ab6-af64-52685bcb1dfc",
                                "name": "股骨发育不良-特殊面容综合征"
                            },
                            {
                                "uuid": "72671ba9-8931-456c-92d5-b9828755be0a",
                                "name": "Larsen syndrome"
                            },
                            {
                                "uuid": "e5a33fa5-edb9-42d2-b1b3-d001c1d4f40c",
                                "name": "Fanconi anemia"
                            },
                            {
                                "uuid": "cd6709c4-28f9-499f-b389-c9b5c762378c",
                                "name": "Freeman-Sheldon 综合征（吹口哨面容）"
                            },
                            {
                                "uuid": "31f22ec5-5f87-4456-8ed2-92eac9387dfa",
                                "name": "Roberts syndrome"
                            },
                            {
                                "uuid": "d3551fa6-5242-4a04-93c8-ab88f30a9fb7",
                                "name": "股骨-腓骨-尺骨综合症（FFU）"
                            },
                            {
                                "uuid": "fd4d81ae-8e85-4297-b123-7af7be740b3f",
                                "name": "Adams-Oliver syndrome"
                            }
                        ]
                    },
                    {
                        "uuid": 6,
                        "name": "骨骼发育不良为特征",
                        "children": [
                            {
                                "uuid": "a185f94c-4ce9-4a0f-bb2d-3e85c48a2e89",
                                "name": "扭曲性骨发育不全"
                            },
                            {
                                "uuid": "cc9f94fc-80a1-4cbe-a04d-00ccefd24986",
                                "name": "先天性骨骺发育不良"
                            },
                            {
                                "uuid": "cb4e1042-7392-4d90-8e9a-5b6a994bf6e3",
                                "name": "颅-锁骨发育不全"
                            },
                            {
                                "uuid": "64f4324e-8075-4004-b70e-6b7e0ca47739",
                                "name": "Chondrodysplasia punctata, rhizomelic type"
                            },
                            {
                                "uuid": "93f64eeb-7f23-4a0d-ad8c-1c3da04e8308",
                                "name": "短肋-多指综合征 I型及III型"
                            },
                            {
                                "uuid": "c08db4ba-ed73-47e6-b6c1-fe2c5539405a",
                                "name": "营养不良性骨发育不良"
                            },
                            {
                                "uuid": "2f8c2994-29ab-4c44-b358-bddf870869da",
                                "name": "营养不良性侏儒，II型"
                            },
                            {
                                "uuid": "4991f7b1-bb02-4c24-82de-6fc0bcfa16e7",
                                "name": "Chondrodysplasia punctata, non-rhizomelic type"
                            },
                            {
                                "uuid": "0b2ab8da-cea3-4a9f-bec2-1c6a64df4bb7",
                                "name": "致死型骨质疏松症"
                            },
                            {
                                "uuid": "867beca1-655c-49d3-bca9-1dfe4845a435",
                                "name": "软骨发育不全"
                            },
                            {
                                "uuid": "92b78779-164d-4ffb-a0fa-21031878d2b1",
                                "name": "致死型低磷酸酶血症"
                            },
                            {
                                "uuid": "6d61ae43-a98c-4682-8d97-efe0c93853c7",
                                "name": "短肋--多指综合征II型"
                            },
                            {
                                "uuid": "bc2ff0db-1bc5-4a18-8a9f-cd2028bd4cc5",
                                "name": "软骨成长不全"
                            },
                            {
                                "uuid": "dca24a4d-14ef-4c80-9550-95e2cfb0150a",
                                "name": "软骨外胚层发育不良综合征"
                            },
                            {
                                "uuid": "75b4526b-4b5b-4202-9173-b9ef840f22ad",
                                "name": "窒息性胸廓发育不良"
                            },
                            {
                                "uuid": "119c7a1a-17fb-4cbf-a20b-b80298a81d8a",
                                "name": "肢体屈曲症（CD）"
                            },
                            {
                                "uuid": "d0eb4012-c262-4acb-9ba7-1dc92cb5bbc4",
                                "name": "致死性骨发育不良（ I型和II型）"
                            },
                            {
                                "uuid": "e8e42e9d-6388-4696-970b-e6e84d06889c",
                                "name": "软骨发育不良"
                            },
                            {
                                "uuid": "fb345175-1d53-4e49-b59c-567dc6c4aec0",
                                "name": "骨发育不全症 I型（致死性软骨发育不良）"
                            }
                        ]
                    },
                    {
                        "uuid": 3,
                        "name": "颜面部异常为特征",
                        "children": [
                            {
                                "uuid": "ab8d20c3-7b40-4b68-bec7-2d78f5327f1c",
                                "name": "口-面-指综合征Ⅰ型"
                            },
                            {
                                "uuid": "98f8c3a1-94a9-4a82-8a0b-e1c82f4d9b10",
                                "name": "Stickler syndrome"
                            },
                            {
                                "uuid": "3c1262d5-a1cf-44a0-a7e5-15ab8bc9487a",
                                "name": "腭-心-面综合征（22q11微缺失）"
                            },
                            {
                                "uuid": "35d9a9d3-34d8-4dad-9c9b-e7ba7d580804",
                                "name": "Pierre Robin syndrome"
                            },
                            {
                                "uuid": "fda3594a-1f7a-4871-b5a6-f0642b0c876e",
                                "name": "大脑-肋骨-下颌综合征"
                            },
                            {
                                "uuid": "87b3b9af-c9b0-461e-99a2-08441171bc5f",
                                "name": "肢端-面骨发育异常综合征"
                            },
                            {
                                "uuid": "83c07044-a751-4dcb-8145-babbe5e26e65",
                                "name": "口-面-指综合征Ⅱ型"
                            },
                            {
                                "uuid": "6b2971f4-803e-4d02-b2f6-2c43126ccc52",
                                "name": "腮-眼-面畸形综合征"
                            },
                            {
                                "uuid": "63a91a28-a0a7-4559-b8b8-2bd7428eaf91",
                                "name": "Treacher Collins syndrome"
                            },
                            {
                                "uuid": "e56b9e45-4040-4842-bde5-104b1267dea6",
                                "name": "正中面裂综合征"
                            },
                            {
                                "uuid": "bec6933b-3e88-425e-b315-afe9b03107cf",
                                "name": "眼-耳-脊椎综合征"
                            },
                            {
                                "uuid": "478c9340-41b2-4cd9-8834-c225de68ee0a",
                                "name": "Fraser syndrome"
                            }
                        ]
                    },
                    {
                        "uuid": 9,
                        "name": "软组织异常为特征",
                        "children": [
                            {
                                "uuid": "05626a28-fa03-47e3-8d03-6a20813c8b7c",
                                "name": "马凡综合征"
                            },
                            {
                                "uuid": "30258147-a098-466e-8047-e04f1aa8d8bb",
                                "name": "Proteous syndrome"
                            },
                            {
                                "uuid": "dcd3367b-1c12-4136-b620-1052bcb2303d",
                                "name": "鱼鳞病"
                            },
                            {
                                "uuid": "e5dd707c-e20e-4ced-bfa5-af69872206e5",
                                "name": "α-地中海贫血"
                            },
                            {
                                "uuid": "d145addb-4094-42e1-814c-3f2bfc866f3c",
                                "name": "克-特综合征"
                            },
                            {
                                "uuid": "c0c0c66b-2b0b-4526-b7d4-88b5d399a0d1",
                                "name": "先天性皮肤发育不全"
                            },
                            {
                                "uuid": "c73cdef9-fb7d-4f3f-ab2a-3bbfeff04a95",
                                "name": "结节硬化症（TS）"
                            },
                            {
                                "uuid": "4ce53c90-fa0a-460c-8d12-6bfa0e5283fc",
                                "name": "成骨不全 II型"
                            }
                        ]
                    },
                    {
                        "uuid": 7,
                        "name": "颅缝早闭为特征",
                        "children": [
                            {
                                "uuid": "51dd9f0a-c422-41d5-8283-c819595c4114",
                                "name": "尖头多指并指畸形 Ⅱ型"
                            },
                            {
                                "uuid": "5f5374de-30f0-4499-a1f5-3e42b4045733",
                                "name": "Antley-Bixler syndrome"
                            },
                            {
                                "uuid": "cf28b31b-dcc9-4373-afba-4271c8b3d5f6",
                                "name": "颅骨面骨发育不良，I型"
                            },
                            {
                                "uuid": "cd61905d-3767-4c8f-b2f0-e3bc693f281d",
                                "name": "面骨发育不良"
                            },
                            {
                                "uuid": "86c41714-7684-45a7-9248-58c0ad8b07a1",
                                "name": "Saethre-Chotzen syndrome"
                            },
                            {
                                "uuid": "0d8b71dc-9536-4cb9-be9b-e490bfb9ff4d",
                                "name": "尖头并指畸形 I型"
                            }
                        ]
                    },
                    {
                        "uuid": 1,
                        "name": "生长发育受限为特征",
                        "children": [
                            {
                                "uuid": "a38a57e1-cff3-49a2-bb88-b82eb0bb9bcb",
                                "name": "德朗热综合征"
                            },
                            {
                                "uuid": "47483018-f131-4e57-8c46-d42fd8405ede",
                                "name": "小头-小颌-幷指综合征"
                            },
                            {
                                "uuid": "8d1b80dc-474d-4710-a2a5-99f256191504",
                                "name": "Noonan syndrome"
                            },
                            {
                                "uuid": "303c0792-dfdf-4e08-a7b4-74d89d46949f",
                                "name": "鸟样头-侏儒综合征"
                            },
                            {
                                "uuid": "252659e5-48cc-4c5d-b3c4-02fa08d911cf",
                                "name": "不对称身材矮小性发育异常综合征"
                            },
                            {
                                "uuid": "546283ba-dad4-4a90-8b9e-fd4e8c9b3698",
                                "name": "测试版本用综合征"
                            }
                        ]
                    },
                    {
                        "uuid": 2,
                        "name": "生长过度为特征",
                        "children": [
                            {
                                "uuid": "6e198003-bd40-42e4-ad24-2f6ab3c2a892",
                                "name": "Perlman syndrome"
                            },
                            {
                                "uuid": "a1fc41f8-c692-49d0-9f6c-8e154ef025a4",
                                "name": "妊娠期糖尿病"
                            },
                            {
                                "uuid": "fd45d1d3-24fe-426d-b460-ec4e699b027e",
                                "name": "脐膨出-巨舌-巨体综合征"
                            }
                        ]
                    },
                    {
                        "uuid": 8,
                        "name": "多发异常为特征",
                        "children": [
                            {
                                "uuid": "c2ca1fe7-7b21-4664-9a2c-d505cb96e061",
                                "name": "脊柱胸廓发育不良"
                            },
                            {
                                "uuid": "ab308da3-9de1-4267-85d1-4d751861c402",
                                "name": "Fryns syndrome"
                            },
                            {
                                "uuid": "f308ce8a-15ad-4c91-9636-a1a26288e361",
                                "name": "囊性纤维化"
                            },
                            {
                                "uuid": "228b54ee-1cbf-45ac-8eb2-a1b49a9868e1",
                                "name": "婴儿型多囊肾"
                            }
                        ]
                    }
                ]
            },
            {
                "uuid": 2,
                "name": "宫内感染",
                "children": [
                    {
                        "uuid": "04fc1935-4acd-4daa-bb43-2e3c0fa94591",
                        "name": "风疹病毒"
                    },
                    {
                        "uuid": "9637b142-16b6-401f-8bbc-c49e2f0798c2",
                        "name": "巨细胞病毒"
                    },
                    {
                        "uuid": "50c4a25c-840e-4f1f-aa06-05b9f487967e",
                        "name": "弓形虫"
                    },
                    {
                        "uuid": "e0d0c340-9acf-4913-bf8b-5c02abad86d0",
                        "name": "梅毒"
                    },
                    {
                        "uuid": "dce74bde-a593-4506-a0d5-0c2206db96d5",
                        "name": "水痘"
                    },
                    {
                        "uuid": "d699abbe-ae59-4ce3-b40a-7345695fc087",
                        "name": "微小病毒B （传染性红斑）"
                    }
                ]
            },
            {
                "uuid": 3,
                "name": "致畸剂",
                "children": [
                    {
                        "uuid": "ed29fe05-ddcc-470a-bd02-d1791e141e52",
                        "name": "咪唑硫嘌呤（抗肿瘤药）"
                    },
                    {
                        "uuid": "892d07c5-8a46-4d01-a362-7c1e167be9bb",
                        "name": "环丙沙星（喹诺酮类）"
                    },
                    {
                        "uuid": "34f03ef4-599f-4bff-ac52-45df3e5251e9",
                        "name": "酰胺咪嗪（卡马西平，抗癫痫药）"
                    },
                    {
                        "uuid": "124764a5-e52e-430c-9681-ef46cd199485",
                        "name": "阿米替林（镇静剂，抗抑郁药）"
                    },
                    {
                        "uuid": "d28645a1-c982-4cb5-9622-dfd8d164a92b",
                        "name": "乙醇"
                    },
                    {
                        "uuid": "fc39e88b-05fd-44a5-99aa-9e3cbafbf8a8",
                        "name": "乙酰唑胺（治疗青光眼）"
                    },
                    {
                        "uuid": "f7af5e4b-0223-4143-9eac-ec6f92ca3672",
                        "name": "氨喋呤（抗叶酸剂）"
                    },
                    {
                        "uuid": "05adb0ad-0939-498b-bd25-352418a8b3d7",
                        "name": "克罗米酚（激素类）"
                    },
                    {
                        "uuid": "c19d2618-bf61-4a48-a525-87c997f2a3fe",
                        "name": "一氧化碳"
                    },
                    {
                        "uuid": "ad975681-5fc2-4059-a0fe-1d97a9a7dd19",
                        "name": "氯磺丙脲（降血糖药）"
                    },
                    {
                        "uuid": "e1b0ea59-b14f-4eff-bed5-55f0b060d25c",
                        "name": "氯硝西泮（抗癫痫药）"
                    },
                    {
                        "uuid": "a4ada5b1-bed3-4a2b-9a1d-88fc4c7fde31",
                        "name": "氯苯吡胺（扑尔敏）"
                    },
                    {
                        "uuid": "b97fab0f-fcae-42c0-89cf-904b33a4aa5d",
                        "name": "乙酰水杨酸（阿司匹林）"
                    },
                    {
                        "uuid": "8f6ff0fc-a4bc-4cec-861f-0be4766f5464",
                        "name": "甲氨二氮草（利眠宁）"
                    },
                    {
                        "uuid": "7c778ecb-ef71-483b-93de-5e064f195c87",
                        "name": "抗甲状腺药物"
                    },
                    {
                        "uuid": "0f26b244-be8f-4056-8c85-aa29f27a903c",
                        "name": "阿糖孢苷（抗肿瘤药）"
                    },
                    {
                        "uuid": "056dfe59-9168-48af-9007-53e8f3b6b3c1",
                        "name": "母体苯丙酮尿症（PKU）"
                    },
                    {
                        "uuid": "71fcf719-5b0c-432e-bc3b-0d658869e438",
                        "name": "氟非那嗪（镇静剂，抗抑郁药）"
                    },
                    {
                        "uuid": "c70e6616-1a1a-49fa-9597-00b95e263aec",
                        "name": "奎宁（抗生素）"
                    },
                    {
                        "uuid": "7af7238e-f0ce-419a-b9f5-ce14266f2c4e",
                        "name": "口服避孕药（激素类）"
                    },
                    {
                        "uuid": "bd35540b-757f-48eb-8459-40b3b339651c",
                        "name": "雌激素（激素类）"
                    },
                    {
                        "uuid": "e7a7f7a3-a59e-4744-a620-c239cdc1d0c5",
                        "name": "甲基苄肼（抗肿瘤药物）"
                    },
                    {
                        "uuid": "86b1bf23-a494-47c5-9a0c-b5fe706f4380",
                        "name": "甲丙氨酯（镇静剂，抗抑郁药）"
                    },
                    {
                        "uuid": "a7e73d7b-7a4b-46e1-adff-5e8fb5d6f4db",
                        "name": "苯肾上腺素（抗休克药）"
                    },
                    {
                        "uuid": "0e4cdd26-2815-4fe1-8fd5-ce535a1d1b2a",
                        "name": "甲氨蝶呤（抗肿瘤药）"
                    },
                    {
                        "uuid": "ff62f40b-fd0d-4186-84b1-9efbabb5e335",
                        "name": "右旋安非他命（中枢神经兴奋剂）"
                    },
                    {
                        "uuid": "fa0d16bf-56d6-48ca-b6d2-84a85e084fe3",
                        "name": "氟西汀（百忧解）（镇静剂，抗抑郁药）"
                    },
                    {
                        "uuid": "3270ab61-dcb9-4f33-baef-c24b3f41e379",
                        "name": "孕酮（激素类）"
                    },
                    {
                        "uuid": "1a82aa2e-b4ed-4cfa-83b4-89f55d76c45c",
                        "name": "环磷酰胺（抗肿瘤药）"
                    },
                    {
                        "uuid": "8b7391cc-dbdd-4c68-ae4e-068aead3ff05",
                        "name": "去甲阿米替林（镇静剂，抗抑郁药）"
                    },
                    {
                        "uuid": "e827e718-a2ca-49ab-ab71-51f209565197",
                        "name": "辐射（大剂量）"
                    },
                    {
                        "uuid": "5d80f935-3115-47e9-929e-babcedb647ce",
                        "name": "普萘洛尔（心得安，抗心律失常药）"
                    },
                    {
                        "uuid": "83fa6116-b54c-4c7f-a088-3b7d5533f763",
                        "name": "苯丙胺醇（PPA，气道扩张药）"
                    },
                    {
                        "uuid": "99f37198-d6fa-4caa-a162-38c64c2d2e33",
                        "name": "三甲双酮（抗惊厥药）"
                    },
                    {
                        "uuid": "0aa5d95f-308f-46de-96bb-c783b5540511",
                        "name": "乙琥胺（抗癫痫药）"
                    },
                    {
                        "uuid": "0f54a2da-dbae-4c51-8db4-3747688f8b40",
                        "name": "氟哌啶醇（镇静剂，抗抑郁药）"
                    },
                    {
                        "uuid": "5278b9f3-9d35-44fe-8d5c-56d8ffbbdd11",
                        "name": "氯苯甲嗪（抗组胺药，止晕止吐）"
                    },
                    {
                        "uuid": "9fdffcb3-ead2-42c1-be40-cd58137adbb6",
                        "name": "吲哚美辛（消炎痛）"
                    },
                    {
                        "uuid": "357ee6e3-ebe0-44ad-b77a-5a2eb5084a07",
                        "name": "高热（受孕14-28天母体体温＞39摄氏度）"
                    },
                    {
                        "uuid": "9795e126-0dd6-4519-b929-f92bede10978",
                        "name": "可卡因"
                    },
                    {
                        "uuid": "5371c151-1ee3-42a4-8000-f2b59e705042",
                        "name": "可的松（激素类）"
                    },
                    {
                        "uuid": "d97d940d-f4de-4e08-a56a-eabd21d1bd4b",
                        "name": "乙内酰脲（抗惊厥药）"
                    },
                    {
                        "uuid": "0a13c8f1-c46c-4bd9-800d-1c166604653e",
                        "name": "丙咪嗪（镇静剂，抗抑郁药）"
                    },
                    {
                        "uuid": "1a7bbde3-23c5-417d-827c-1e76bedb386e",
                        "name": "甲硝唑（灭滴灵，抗生素）"
                    },
                    {
                        "uuid": "677c5032-9d36-4003-a244-07615b77e3e0",
                        "name": "四环素（抗生素）"
                    },
                    {
                        "uuid": "262204c8-245f-47a8-aa54-f9e52a71044f",
                        "name": "甲妥因（抗癫痫药）"
                    },
                    {
                        "uuid": "01e389f5-fa1a-42e9-ba58-fd1d9a512ac3",
                        "name": "硫鸟嘌呤（抗肿瘤药）"
                    },
                    {
                        "uuid": "e298ad6a-db65-4d89-b574-60197e8401f2",
                        "name": "吩噻嗪（镇静剂，抗抑郁药）"
                    },
                    {
                        "uuid": "60433b31-894d-41f0-8679-0c7ebc44fcf7",
                        "name": "可待因（鸦片类药，镇咳止痛）"
                    },
                    {
                        "uuid": "99e22627-6e6b-4419-8034-d09c3b051920",
                        "name": "华法林（香豆素，抗凝药）"
                    },
                    {
                        "uuid": "66fe8a8b-9feb-48aa-bb0f-66e45443b5a2",
                        "name": "吸烟"
                    },
                    {
                        "uuid": "ad1cee41-01db-4aaf-971d-22182970931f",
                        "name": "氟二氧嘧啶（抗肿瘤药）"
                    },
                    {
                        "uuid": "3d4e60d1-1658-4906-9c90-643f4238ecdd",
                        "name": "沙利度胺（反应停）"
                    },
                    {
                        "uuid": "712111f5-952e-451d-a005-ce9a8b56d01d",
                        "name": "丙戊酸（抗惊厥药）"
                    }
                ]
            }
        ]

        list.updateModel(data)
    }
}
