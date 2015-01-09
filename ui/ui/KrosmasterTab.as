package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.FileApi;
    import d2api.TooltipApi;
    import flash.geom.ColorTransform;
    import d2components.Grid;
    import d2components.Label;
    import d2hooks.KrosmasterInventory;
    import d2hooks.KrosmasterInventoryError;
    import d2hooks.KrosmasterTransfer;
    import d2enums.ComponentHookList;
    import d2actions.KrosmasterInventoryRequest;
    import d2components.Texture;
    import d2network.KrosmasterFigure;
    import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
    import d2actions.KrosmasterTransferRequest;
    import d2enums.KrosmasterErrorEnum;
    import d2enums.KrosmasterTransferEnum;
    import d2hooks.*;
    import d2actions.*;

    public class KrosmasterTab 
    {

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var fileApi:FileApi;
        public var tooltipApi:TooltipApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        private var _colorDisable:ColorTransform;
        private var _coloravailable:ColorTransform;
        private var _allFigures:Array;
        private var _myFigures:Array;
        private var _selectedFigureId:int;
        public var gd_collection:Grid;
        public var lbl_collection:Label;

        public function KrosmasterTab()
        {
            this._colorDisable = new ColorTransform(1, 1, 1, 0.2);
            this._coloravailable = new ColorTransform();
            this._allFigures = new Array();
            this._myFigures = new Array();
            super();
        }

        public function main(oParam:Object=null):void
        {
            this.fileApi.loadXmlFile("assets/figures.xml", this.onFigureDataloaded);
            this.sysApi.addHook(KrosmasterInventory, this.onKrosmasterInventory);
            this.sysApi.addHook(KrosmasterInventoryError, this.onKrosmasterInventoryError);
            this.sysApi.addHook(KrosmasterTransfer, this.onKrosmasterTransfer);
            this.uiApi.addComponentHook(this.gd_collection, ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(this.gd_collection, ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(this.gd_collection, ComponentHookList.ON_SELECT_ITEM);
            this.sysApi.sendAction(new KrosmasterInventoryRequest());
        }

        public function updateLine(data:*, componentsRef:*, selected:Boolean):void
        {
            if (data)
            {
                componentsRef.lbl_name.text = data.name;
                componentsRef.tx_figure.uri = data.uri;
                if (((this._myFigures[data.id]) && ((this._myFigures[data.id].length > 0))))
                {
                    Texture(componentsRef.tx_figure).transform.colorTransform = this._coloravailable;
                    componentsRef.lbl_number.text = this._myFigures[data.id].length;
                }
                else
                {
                    Texture(componentsRef.tx_figure).transform.colorTransform = this._colorDisable;
                    componentsRef.lbl_number.text = "";
                };
                componentsRef.tx_figureBg.visible = true;
            }
            else
            {
                componentsRef.lbl_name.text = "";
                componentsRef.lbl_number.text = "";
                componentsRef.tx_figure.uri = null;
                componentsRef.tx_figureBg.visible = false;
            };
        }

        private function myFiguresCount():int
        {
            var fig:String;
            var count:int;
            for (fig in this._myFigures)
            {
                if (((this._myFigures[fig]) && ((this._myFigures[fig].length > 0))))
                {
                    count++;
                };
            };
            return (count);
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            var allBounded:Boolean;
            var fig:KrosmasterFigure;
            if (selectMethod == GridItemSelectMethodEnum.DOUBLE_CLICK)
            {
                this._selectedFigureId = target.selectedItem.id;
                if (((this._myFigures[this._selectedFigureId]) && ((this._myFigures[this._selectedFigureId].length > 0))))
                {
                    allBounded = true;
                    for each (fig in this._myFigures[this._selectedFigureId])
                    {
                        if (fig.bound == false)
                        {
                            allBounded = false;
                            break;
                        };
                    };
                    if (!(allBounded))
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.krosmaster.transferConfirm"), [this.uiApi.getText("ui.common.ok"), this.uiApi.getText("ui.common.cancel")], [this.onValidTransfer, this.onPopupClose], this.onValidTransfer, this.onPopupClose);
                    }
                    else
                    {
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.krosmaster.boundFigure"), [this.uiApi.getText("ui.common.ok")], [this.onPopupClose], this.onPopupClose);
                    };
                };
            };
        }

        public function onItemRollOver(target:Object, item:Object):void
        {
            if (item.data)
            {
                KrosmasterCardViewer.show(item.data.id, item.container);
            };
        }

        public function onItemRollOut(target:Object, item:Object):void
        {
            if (item.data)
            {
                KrosmasterCardViewer.hide();
            };
        }

        public function unload():void
        {
            KrosmasterCardViewer.hide(true);
        }

        public function onValidTransfer():void
        {
            var fig:KrosmasterFigure;
            for each (fig in this._myFigures[this._selectedFigureId])
            {
                if (fig.bound == false)
                {
                    this.sysApi.sendAction(new KrosmasterTransferRequest(fig.uid));
                    return;
                };
            };
        }

        public function onPopupClose():void
        {
        }

        private function onFigureDataloaded(xmlData:XML):void
        {
            var figure:XML;
            var f:Figure;
            this._allFigures = new Array();
            var lang:String = this.sysApi.getCurrentLanguage();
            if ((((lang == "ru")) || ((lang == "ja"))))
            {
                lang = "en";
            };
            for each (figure in xmlData..figure)
            {
                f = new Figure();
                f.id = figure.id;
                f.name = figure.name[lang].toString();
                f.uri = this.uiApi.createUri(((((this.sysApi.getConfigEntry("config.gfx.path") + "krosmaster/icons/") + (((f.id < 100)) ? ("0" + (((f.id < 10)) ? "0" : "")) : "")) + f.id) + "_icon150.png"));
                this._allFigures.push(f);
            };
            this._allFigures.sortOn("id", Array.NUMERIC);
            this.gd_collection.dataProvider = this._allFigures;
            this.lbl_collection.text = this.uiApi.getText("ui.krosmaster.collectionContent", this.myFiguresCount(), this._allFigures.length);
        }

        private function onKrosmasterInventory(inventory:Object):void
        {
            var figure:KrosmasterFigure;
            for each (figure in inventory)
            {
                if (!(this._myFigures[figure.figure]))
                {
                    this._myFigures[figure.figure] = new Array();
                };
                this._myFigures[figure.figure].push(figure);
            };
            if (((this._allFigures) && ((this._allFigures.length > 0))))
            {
                this.lbl_collection.text = this.uiApi.getText("ui.krosmaster.collectionContent", this.myFiguresCount(), this._allFigures.length);
                this.gd_collection.dataProvider = this._allFigures;
            };
        }

        private function onKrosmasterInventoryError(reason:int):void
        {
            var text:String;
            switch (reason)
            {
                case KrosmasterErrorEnum.KROSMASTER_ERROR_ICE_KO:
                    text = this.uiApi.getText("ui.popup.accessDenied.serviceUnavailable");
                    break;
                case KrosmasterErrorEnum.KROSMASTER_ERROR_ICE_REFUSED:
                    text = this.uiApi.getText("ui.krosmaster.figuresListAccessDenied");
                    break;
                case KrosmasterErrorEnum.KROSMASTER_ERROR_UNDEFINED:
                default:
                    text = this.uiApi.getText("ui.secureMode.error.default");
            };
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), text, [this.uiApi.getText("ui.common.ok")], [this.onPopupClose], this.onPopupClose);
        }

        private function onKrosmasterTransfer(uid:String, failure:int):void
        {
            var figType:Object;
            var typeCopy:Array;
            var fig:KrosmasterFigure;
            var figIndex:Object;
            var v:int;
            if (failure == KrosmasterTransferEnum.KROSMASTER_TRANSFER_OK)
            {
                for (figType in this._myFigures)
                {
                    if (((this._myFigures[figType]) && ((this._myFigures[figType].length > 0))))
                    {
                        typeCopy = new Array();
                        for each (fig in this._myFigures[figType])
                        {
                            typeCopy.push(fig);
                        };
                        for (figIndex in typeCopy)
                        {
                            if (typeCopy[figIndex].uid == uid)
                            {
                                this._myFigures[figType].splice(figIndex, 1);
                                v = this.gd_collection.verticalScrollValue;
                                this.gd_collection.updateItems();
                                this.gd_collection.verticalScrollValue = v;
                                this.lbl_collection.text = this.uiApi.getText("ui.krosmaster.collectionContent", this.myFiguresCount(), this._allFigures.length);
                                return;
                            };
                        };
                    };
                };
            };
        }


    }
}//package ui

class Figure 
{

    public var id:uint;
    public var name:String;
    public var uri;


}

