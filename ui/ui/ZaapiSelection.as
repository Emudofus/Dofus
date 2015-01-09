package ui
{
    import d2data.TeleportDestinationWrapper;
    import d2actions.TeleportRequest;
    import d2actions.*;
    import d2hooks.*;

    public class ZaapiSelection extends ZaapSelection 
    {


        override public function main(params:Array):void
        {
            lbl_btn_tab1.text = uiApi.getText("ui.map.craftHouse");
            lbl_btn_tab2.text = uiApi.getText("ui.map.bidHouse");
            lbl_btn_tab3.text = uiApi.getText("ui.common.misc");
            lbl_zaapTitle.text = uiApi.getText("ui.zaap.zaapi");
            lbl_noDestination.visible = false;
            super.main(params);
            btn_showUnknowZaap.visible = false;
        }

        private function validateZaapChoice():void
        {
            var selectedZaap:TeleportDestinationWrapper = gd_zaap.selectedItem;
            if (!(selectedZaap))
            {
                return;
            };
            sysApi.sendAction(new TeleportRequest(1, selectedZaap.mapId, selectedZaap.cost));
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case btn_tab1:
                    _tab1List = sortZaap(_tab1List, "name");
                    gd_zaap.dataProvider = _tab1List;
                    break;
                case btn_tab2:
                    _tab2List = sortZaap(_tab2List, "name");
                    gd_zaap.dataProvider = _tab2List;
                    break;
                case btn_tab3:
                    _tab3List = sortZaap(_tab3List, "name");
                    gd_zaap.dataProvider = _tab3List;
                    break;
            };
            super.onRelease(target);
        }

        override public function onZaapList(zaapList:Object):void
        {
            var i:*;
            _tab1List = new Array();
            _tab2List = new Array();
            _tab3List = new Array();
            for (i in zaapList)
            {
                if (zaapList[i].mapId == playerApi.currentMap().mapId)
                {
                    lbl_zaapTitle.text = ((uiApi.getText("ui.zaap.zaapi") + " ") + zaapList[i].subArea.name);
                }
                else
                {
                    if (zaapList[i].category == 3)
                    {
                        _tab1List.push(zaapList[i]);
                    }
                    else
                    {
                        if (zaapList[i].category == 2)
                        {
                            _tab2List.push(zaapList[i]);
                        }
                        else
                        {
                            _tab3List.push(zaapList[i]);
                        };
                    };
                };
            };
            if (_tab1List.length == 0)
            {
                btn_tab1.disabled = true;
            }
            else
            {
                _tab1List = sortZaap(_tab1List, "name");
            };
            if (_tab2List.length == 0)
            {
                btn_tab2.disabled = true;
            }
            else
            {
                btn_tab2.disabled = false;
                _tab2List = sortZaap(_tab2List, "name");
            };
            if (_tab3List.length == 0)
            {
                btn_tab3.disabled = true;
            }
            else
            {
                btn_tab3.disabled = false;
                _tab3List = sortZaap(_tab3List, "name");
            };
            if (!(btn_tab1.disabled))
            {
                uiApi.setRadioGroupSelectedItem("tabHGroup", btn_tab1, uiApi.me());
                btn_tab1.selected = true;
                gd_zaap.dataProvider = _tab1List;
            }
            else
            {
                if (!(btn_tab2.disabled))
                {
                    uiApi.setRadioGroupSelectedItem("tabHGroup", btn_tab2, uiApi.me());
                    btn_tab2.selected = true;
                    gd_zaap.dataProvider = _tab2List;
                }
                else
                {
                    if (!(btn_tab3.disabled))
                    {
                        uiApi.setRadioGroupSelectedItem("tabHGroup", btn_tab3, uiApi.me());
                        btn_tab3.selected = true;
                        gd_zaap.dataProvider = _tab3List;
                    };
                };
            };
        }


    }
}//package ui

