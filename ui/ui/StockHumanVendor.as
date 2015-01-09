package ui
{
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.ExchangeShopStockUpdate;
    import d2hooks.KeyUp;
    import d2hooks.ExchangeLeave;
    import d2enums.ComponentHookList;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2actions.LeaveDialogRequest;
    import d2actions.CloseInventory;

    public class StockHumanVendor extends StockMyselfVendor 
    {


        override public function main(oParam:Object=null):void
        {
            MODE = HUMAN_VENDOR;
            btnSearch.soundId = SoundEnum.CHECKBOX_CHECKED;
            btnEquipable.soundId = SoundEnum.TAB;
            btnConsumables.soundId = SoundEnum.TAB;
            btnRessources.soundId = SoundEnum.TAB;
            btnAll.soundId = SoundEnum.TAB;
            sysApi.addHook(ExchangeShopStockUpdate, onExchangeShopStockUpdate);
            sysApi.addHook(KeyUp, onKeyUp);
            sysApi.addHook(ExchangeLeave, onExchangeLeave);
            uiApi.addComponentHook(searchInput, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(searchInput, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(btnAll, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(btnAll, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(btnEquipable, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(btnEquipable, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(btnConsumables, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(btnConsumables, ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(btnRessources, ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(btnRessources, ComponentHookList.ON_ROLL_OUT);
            gd_shop.scrollDisplay = "always";
            gd_shop.autoSelectMode = 0;
            btnAll.selected = true;
            _currentFilterBtn = btnAll;
            _filterAssoc[btnEquipable.name] = EQUIPEMENT_CATEGORY;
            _filterAssoc[btnConsumables.name] = CONSUMABLES_CATEGORY;
            _filterAssoc[btnRessources.name] = RESSOURCES_CATEGORY;
            _filterAssoc[btnAll.name] = ALL_CATEGORY;
            centerCtr.visible = false;
            ctr_bottomInfos.visible = false;
            lbl_title.text = oParam.playerName;
            _shopStock = oParam.objects;
            _category = new Array();
            updateStockInventory();
            btnAll.selected = true;
        }

        override public function unload():void
        {
            uiApi.unloadUi(UIEnum.HUMAN_VENDOR);
            sysApi.sendAction(new LeaveDialogRequest());
            sysApi.sendAction(new CloseInventory());
        }


    }
}//package ui

