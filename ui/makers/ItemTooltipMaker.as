package makers
{
    import d2api.AveragePricesApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.SystemApi;
    import blocks.TextTooltipBlock;
    import blocks.ItemTooltipBlock;
    import blocks.EffectTooltipBlock;
    import blocks.ConditionTooltipBlock;
    import blocks.DescriptionTooltipBlock;
    import d2hooks.*;

    public class ItemTooltipMaker 
    {

        private var _param:paramClass;


        public function createTooltip(data:*, param:Object):Object
        {
            var p:String;
            var efff:*;
            var effect:*;
            var eff:*;
            var effd:*;
            var tempObject:Object;
            var playerSetInfo:Object;
            var averagePricesApi:AveragePricesApi = Api.averagePrices;
            var uiApi:UiApi = Api.ui;
            var utilApi:UtilApi = Api.util;
            var sysApi:SystemApi = Api.system;
            var setMode:Boolean;
            var abstractEffects:Array = new Array();
            this._param = new paramClass();
            var bg:String = "chunks/base/baseWithBackground.txt";
            if (param)
            {
                if (((param.hasOwnProperty("noBg")) && (param.noBg)))
                {
                    bg = "chunks/base/base.txt";
                };
                if (param.hasOwnProperty("setMode"))
                {
                    setMode = param.setMode;
                    delete param.setMode;
                };
                if (param.hasOwnProperty("noBg"))
                {
                    this._param.noBg = param.noBg;
                };
                if (param.hasOwnProperty("description"))
                {
                    this._param.description = param.description;
                };
                if (param.hasOwnProperty("effects"))
                {
                    this._param.effects = param.effects;
                };
                if (param.hasOwnProperty("CC_EC"))
                {
                    this._param.CC_EC = param.CC_EC;
                };
                if (param.hasOwnProperty("header"))
                {
                    this._param.header = param.header;
                };
                if (param.hasOwnProperty("conditions"))
                {
                    this._param.conditions = param.conditions;
                };
                if (param.hasOwnProperty("targetConditions"))
                {
                    this._param.targetConditions = param.targetConditions;
                };
                if (param.hasOwnProperty("length"))
                {
                    this._param.length = param.length;
                };
                if (param.hasOwnProperty("equipped"))
                {
                    this._param.equipped = param.equipped;
                };
                if (param.hasOwnProperty("showEffects"))
                {
                    if (((((param.showEffects) && (data))) && ((data.effects.length <= 0))))
                    {
                        for each (effect in Api.data.getItem(data.objectGID).possibleEffects)
                        {
                            abstractEffects.push(effect);
                        };
                    };
                };
                if (param.hasOwnProperty("averagePrice"))
                {
                    this._param.averagePrice = param.averagePrice;
                };
            };
            var deleteParam:Boolean = true;
            for (p in param)
            {
                deleteParam = false;
                break;
            };
            if (deleteParam)
            {
                param = false;
            };
            var tooltip:Object = Api.tooltip.createTooltip(bg, "chunks/base/container.txt", "chunks/base/separator.txt");
            if (this._param.equipped)
            {
                tooltip.addBlock(new TextTooltipBlock(uiApi.getText("ui.item.equipped"), {
                    "css":"[local.css]normal.css",
                    "classCss":"disabled"
                }).block);
            };
            if (this._param.header)
            {
                tooltip.addBlock(new ItemTooltipBlock(data, param).block);
            };
            var effects:Array = new Array();
            var showTheoretical:Boolean;
            if (abstractEffects.length)
            {
                for each (eff in abstractEffects)
                {
                    effects.push(eff);
                };
                showTheoretical = true;
            }
            else
            {
                for each (effd in data.effects)
                {
                    effects.push(effd);
                };
            };
            for each (efff in data.favoriteEffect)
            {
                effects.push(efff);
            };
            if (((effects.length) && (this._param.effects)))
            {
                if (((((((param.hasOwnProperty("effects")) && (param.effects))) || (((param.hasOwnProperty("damages")) && (param.damages))))) || (((param.hasOwnProperty("specialEffects")) && (param.specialEffects)))))
                {
                    tempObject = new Object();
                    tempObject.damages = null;
                    tempObject.specialEffects = null;
                    if (param.hasOwnProperty("damages"))
                    {
                        tempObject.damages = param.damages;
                    }
                    else
                    {
                        tempObject.damages = true;
                    };
                    if (param.hasOwnProperty("specialEffects"))
                    {
                        tempObject.specialEffects = param.specialEffects;
                    }
                    else
                    {
                        tempObject.specialEffects = true;
                    };
                    tooltip.addBlock(new EffectTooltipBlock(effects, this._param.length, tempObject.damages, showTheoretical, tempObject.specialEffects).block);
                }
                else
                {
                    tooltip.addBlock(new EffectTooltipBlock(effects, this._param.length, true, showTheoretical).block);
                };
            };
            if (((setMode) && (this._param.effects)))
            {
                playerSetInfo = Api.player.getPlayerSet(data.objectGID);
                if (playerSetInfo)
                {
                    tooltip.addBlock(new EffectTooltipBlock(playerSetInfo.setEffects, this._param.length, true, true, true, false, (((((playerSetInfo.setName + " (") + playerSetInfo.setObjects.length) + "/") + playerSetInfo.allItems.length) + ")")).block);
                };
            };
            var cond:Object = data.conditions;
            if (((((cond) && (cond.text))) && (this._param.conditions)))
            {
                tooltip.addBlock(new ConditionTooltipBlock(cond, this._param.length, data.criteria).block);
            };
            var condT:Object = data.targetConditions;
            if (((((condT) && (condT.text))) && (this._param.targetConditions)))
            {
                tooltip.addBlock(new ConditionTooltipBlock(condT, this._param.length, data.criteria, null, true).block);
            };
            if (this._param.description)
            {
                tooltip.addBlock(new DescriptionTooltipBlock(data.description).block);
            };
            if (((((sysApi.isInGame()) && (this._param.averagePrice))) && (data.exchangeable)))
            {
                tooltip.addBlock(new TextTooltipBlock(averagePricesApi.getItemAveragePriceString(data), {"classCss":"p"}).block);
            };
            return (tooltip);
        }


    }
}//package makers

class paramClass 
{

    public var header:Boolean = true;
    public var effects:Boolean = true;
    public var description:Boolean = true;
    public var noBg:Boolean = false;
    public var CC_EC:Boolean = true;
    public var conditions:Boolean = true;
    public var targetConditions:Boolean = true;
    public var length:int = 409;
    public var averagePrice:Boolean = true;
    public var equipped:Boolean = false;


}

