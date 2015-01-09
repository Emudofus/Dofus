package blocks
{
    import d2hooks.*;

    public class ItemTooltipBlock 
    {

        public var playerApi:Object;
        private var _content:String;
        private var _contextual:Boolean = false;
        private var _shortcutKey:String = "";
        private var _item:Object;
        private var _block:Object;
        private var _params:Object;

        public function ItemTooltipBlock(item:Object, param:Object)
        {
            this.playerApi = Api.player;
            this._item = item;
            if ((param is Boolean))
            {
                this._params = null;
            }
            else
            {
                this._params = param;
            };
            if (param.hasOwnProperty("contextual"))
            {
                this._contextual = param.contextual;
            };
            if (param.hasOwnProperty("shortcutKey"))
            {
                this._shortcutKey = param.shortcutKey;
            };
            this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded, this.getContent);
            if (!(item.isWeapon))
            {
                this._block.initChunk([Api.tooltip.createChunkData("header", "chunks/item/header.txt"), Api.tooltip.createChunkData("itemHeaderDetails", "chunks/item/details.txt"), Api.tooltip.createChunkData("simpleText", "chunks/base/simpleText.txt")]);
            }
            else
            {
                this._block.initChunk([Api.tooltip.createChunkData("header", "chunks/item/weaponHeader.txt"), Api.tooltip.createChunkData("itemHeaderDetails", "chunks/item/details.txt"), Api.tooltip.createChunkData("weaponInfos", "chunks/item/weaponInfos.txt"), Api.tooltip.createChunkData("simpleText", "chunks/base/simpleText.txt")]);
            };
        }

        public function onAllChunkLoaded():void
        {
            var weightText:String;
            var shortcutColor:String;
            var effect:Object;
            var range:String;
            var CC_EC:String;
            var sign:String;
            var criticalHit:Object;
            var agility:Object;
            var totalCriticalHit:int;
            var totalAgility:int;
            var baseCritik:int;
            var critikPlusBonus:int;
            var critikRate:int;
            var value:int;
            var criticalMiss:Object;
            var uiApi:Object = Api.ui;
            var sysApi:Object = Api.system;
            var headerText:String = "";
            if ((((this._params == null)) || (this._params.header)))
            {
                headerText = (((((sysApi.getBuildType() == 4)) || ((sysApi.getBuildType() == 5)))) ? (((this._item.name + " (") + this._item.objectGID) + ")") : this._item.name);
                if (this._shortcutKey)
                {
                    shortcutColor = Api.system.getConfigEntry("colors.shortcut");
                    shortcutColor = shortcutColor.replace("0x", "#");
                    headerText = (headerText + ((((" <font color='" + shortcutColor) + "'>(") + this._shortcutKey) + ")</font>"));
                };
            };
            var titleCss:String = "normal";
            if (this._item.itemSetId != -1)
            {
                titleCss = "itemset";
            };
            if (this._item.weight > 1)
            {
                weightText = uiApi.processText(uiApi.getText("ui.common.short.weight", this._item.weight), "m", false);
            }
            else
            {
                weightText = uiApi.processText(uiApi.getText("ui.common.short.weight", this._item.weight), "m", true);
            };
            if (!(this._item.isWeapon))
            {
                this._content = this._block.getChunk("header").processContent({
                    "name":headerText,
                    "level":this._item.level,
                    "cssClass":titleCss
                });
                if ((((this._params == null)) || (this._params.description)))
                {
                    this._content = (this._content + this._block.getChunk("itemHeaderDetails").processContent({
                        "cat":this._item.type.name,
                        "weight":weightText,
                        "cssClass":titleCss
                    }));
                };
                if (this._item.itemSetId != -1)
                {
                    this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":this._item.itemSet.name}));
                };
                for each (effect in this._item.effects)
                {
                    if (effect.effectId == 812)
                    {
                        this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":effect.description}));
                    };
                };
            }
            else
            {
                if (this._item.etheral)
                {
                    titleCss = "etheral";
                };
                if (this._item.range == this._item.minRange)
                {
                    range = this._item.range;
                }
                else
                {
                    range = ((this._item.minRange + " - ") + this._item.range);
                };
                this._content = this._block.getChunk("header").processContent({
                    "name":headerText,
                    "level":this._item.level,
                    "cssClass":titleCss
                });
                if ((((this._params == null)) || (this._params.description)))
                {
                    this._content = (this._content + this._block.getChunk("itemHeaderDetails").processContent({
                        "cat":this._item.type.name,
                        "weight":weightText,
                        "cssClass":titleCss
                    }));
                };
                this._content = (this._content + this._block.getChunk("weaponInfos").processContent({
                    "apCost":this._item.apCost,
                    "range":range,
                    "cssClass":titleCss
                }));
                if (this._item.itemSetId != -1)
                {
                    this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":this._item.itemSet.name}));
                };
                if ((((this._params == null)) || (this._params.description)))
                {
                    if (this._item.twoHanded)
                    {
                        this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":uiApi.getText("ui.common.twoHandsWeapon")}));
                    };
                    if (this._item.maxCastPerTurn)
                    {
                        this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":((uiApi.getText("ui.item.maxUsePerTurn") + Api.ui.getText("ui.common.colon")) + this._item.maxCastPerTurn)}));
                    };
                    if (((this._item.castInLine) && ((this._item.range > 1))))
                    {
                        this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":uiApi.getText("ui.spellInfo.castInLine")}));
                    };
                    if (((!(this._item.castTestLos)) && ((this._item.range > 1))))
                    {
                        this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":uiApi.getText("ui.spellInfo.castWithoutLos")}));
                    };
                };
                if ((((this._params == null)) || (this._params.effects)))
                {
                    for each (effect in this._item.effects)
                    {
                        if (effect.effectId == 812)
                        {
                            this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":effect.description}));
                        };
                    };
                };
                if ((((((this._params == null)) || ((this._params.CC_EC == true)))) && (((this._item.criticalFailureProbability) || (this._item.criticalHitProbability)))))
                {
                    CC_EC = "";
                    if (this._item.criticalHitProbability)
                    {
                        if (this._item.criticalHitBonus > 0)
                        {
                            sign = "+";
                        }
                        else
                        {
                            if (this._item.criticalHitBonus < 0)
                            {
                                sign = "-";
                            };
                        };
                        CC_EC = (CC_EC + ((uiApi.getText("ui.common.short.CriticalHit") + uiApi.getText("ui.common.colon")) + "1/"));
                        if (((!(this._contextual)) || ((this.playerApi.characteristics() == null))))
                        {
                            CC_EC = (CC_EC + this._item.criticalHitProbability);
                        }
                        else
                        {
                            criticalHit = this.playerApi.characteristics().criticalHit;
                            agility = this.playerApi.characteristics().agility;
                            totalCriticalHit = (((criticalHit.alignGiftBonus + criticalHit.base) + criticalHit.contextModif) + criticalHit.objectsAndMountBonus);
                            totalAgility = ((((agility.alignGiftBonus + agility.base) + agility.additionnal) + agility.contextModif) + agility.objectsAndMountBonus);
                            if (totalAgility < 0)
                            {
                                totalAgility = 0;
                            };
                            baseCritik = (this._item.criticalHitProbability - totalCriticalHit);
                            critikPlusBonus = int((((baseCritik * Math.E) * 1.1) / Math.log((totalAgility + 12))));
                            critikRate = Math.min(baseCritik, critikPlusBonus);
                            if (critikRate < 2)
                            {
                                critikRate = 2;
                            };
                            CC_EC = (CC_EC + critikRate);
                        };
                        if (sign)
                        {
                            CC_EC = (CC_EC + ((((" (" + sign) + this._item.criticalHitBonus) + uiApi.getText("ui.common.damageShort")) + ")"));
                        };
                    };
                    if (this._item.criticalFailureProbability)
                    {
                        value = this._item.criticalFailureProbability;
                        if (this.playerApi.characteristics())
                        {
                            criticalMiss = this.playerApi.characteristics().criticalMiss;
                            value = (value + (((criticalMiss.alignGiftBonus - criticalMiss.base) - criticalMiss.contextModif) - criticalMiss.objectsAndMountBonus));
                        };
                        CC_EC = (CC_EC + (((((((this._item.criticalHitProbability) ? " - " : "") + uiApi.getText("ui.common.short.CriticalFailure")) + uiApi.getText("ui.common.colon")) + "1/") + value) + " "));
                    };
                    this._content = (this._content + this._block.getChunk("simpleText").processContent({"text":CC_EC}));
                };
            };
        }

        public function getContent():String
        {
            return (this._content);
        }

        public function get block():Object
        {
            return (this._block);
        }


    }
}//package blocks

