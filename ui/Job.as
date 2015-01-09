package 
{
    import flash.display.Sprite;
    import ui.Craft;
    import ui.Decraft;
    import ui.CrafterForm;
    import ui.CrafterList;
    import ui.items.CrafterXmlItem;
    import ui.CraftCoop;
    import ui.SmithMagic;
    import ui.SmithMagicCoop;
    import ui.JobLevelUp;
    import ui.CheckCraft;
    import ui.items.RecipeDetailsItem;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.JobsApi;
    import d2api.SocialApi;
    import d2api.PlayedCharacterApi;
    import d2api.StorageApi;
    import d2hooks.ExchangeStartOkCraft;
    import d2hooks.ExchangeStartOkMultiCraft;
    import d2hooks.ExchangeMultiCraftRequest;
    import d2hooks.ExchangeStartOkJobIndex;
    import d2hooks.JobLevelUp;
    import d2hooks.ExchangeLeave;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2hooks.OpenInventory;
    import d2enums.ExchangeTypeEnum;
    import d2actions.ExchangeAccept;
    import d2actions.ExchangeRefuse;
    import d2actions.AddIgnored;

    public class Job extends Sprite 
    {

        protected var craft:Craft;
        protected var decraft:Decraft;
        protected var crafterForm:CrafterForm;
        protected var crafterList:CrafterList;
        protected var crafterXmlItem:CrafterXmlItem;
        protected var craftCoop:CraftCoop;
        protected var smithMagic:SmithMagic;
        protected var smithMagicCoop:SmithMagicCoop;
        protected var jobLevelUp:JobLevelUp;
        protected var checkCraft:CheckCraft;
        protected var jobRecipeItem:RecipeDetailsItem;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var jobsApi:JobsApi;
        public var socialApi:SocialApi;
        public var playerApi:PlayedCharacterApi;
        public var storageApi:StorageApi;
        private var _popupName:String;
        private var _ignoreName:String;


        public function main():void
        {
            this.sysApi.addHook(ExchangeStartOkCraft, this.onExchangeStartOkCraft);
            this.sysApi.addHook(ExchangeStartOkMultiCraft, this.onExchangeStartOkMultiCraft);
            this.sysApi.addHook(ExchangeMultiCraftRequest, this.onExchangeMultiCraftRequest);
            this.sysApi.addHook(ExchangeStartOkJobIndex, this.onExchangeStartOkJobIndex);
            this.sysApi.addHook(JobLevelUp, this.onJobLevelUp);
            this.sysApi.addHook(ExchangeLeave, this.onExchangeLeave);
        }

        private function onExchangeStartOkCraft(recipes:Object, skillId:uint, nbCase:uint):void
        {
            this.sysApi.disableWorldInteraction();
            var skill:Object = this.jobsApi.getSkillFromId(skillId);
            if (((skill.isForgemagus) || (!((skill.modifiableItemType == -1)))))
            {
                if (!(this.uiApi.getUi(UIEnum.SMITH_MAGIC)))
                {
                    this.uiApi.loadUi(UIEnum.SMITH_MAGIC, UIEnum.SMITH_MAGIC, {
                        "recipes":recipes,
                        "skillId":skillId,
                        "nbCase":nbCase
                    });
                };
                this.sysApi.dispatchHook(OpenInventory, "smithMagic");
            }
            else
            {
                if (skillId == 181)
                {
                    if (!(this.uiApi.getUi(UIEnum.CRAFT)))
                    {
                        this.uiApi.loadUi(UIEnum.DECRAFT, UIEnum.CRAFT, {
                            "recipes":recipes,
                            "skillId":skillId,
                            "nbCase":nbCase
                        });
                    };
                    this.sysApi.dispatchHook(OpenInventory, "decraft");
                }
                else
                {
                    if (!(this.uiApi.getUi(UIEnum.CRAFT)))
                    {
                        this.uiApi.loadUi(UIEnum.CRAFT, UIEnum.CRAFT, {
                            "recipes":recipes,
                            "skillId":skillId,
                            "nbCase":nbCase
                        });
                    };
                    this.sysApi.dispatchHook(OpenInventory, "craft");
                };
            };
        }

        private function onExchangeStartOkMultiCraft(skillId:int, recipes:Object, nbCase:uint, crafterInfos:Object, customerInfos:Object):void
        {
            var characterInfos:Object;
            this.sysApi.disableWorldInteraction();
            var skill:Object = this.jobsApi.getSkillFromId(skillId);
            if (this.uiApi.getUi(this._popupName))
            {
                this.uiApi.unloadUi(this._popupName);
            };
            if (((skill.isForgemagus) || (skill.isRepair)))
            {
                if (!(this.uiApi.getUi(UIEnum.SMITH_MAGIC_COOP)))
                {
                    this.uiApi.loadUi(UIEnum.SMITH_MAGIC_COOP, UIEnum.SMITH_MAGIC, {
                        "skillId":skillId,
                        "recipes":recipes,
                        "nbCase":nbCase,
                        "crafterInfos":crafterInfos,
                        "customerInfos":customerInfos
                    });
                };
                characterInfos = this.playerApi.getPlayedCharacterInfo();
                this.sysApi.dispatchHook(OpenInventory, "smithMagicCoop");
            }
            else
            {
                if (!(this.uiApi.getUi(UIEnum.CRAFT_COOP)))
                {
                    this.uiApi.loadUi(UIEnum.CRAFT_COOP, UIEnum.CRAFT, {
                        "skillId":skillId,
                        "recipes":recipes,
                        "nbCase":nbCase,
                        "crafterInfos":crafterInfos,
                        "customerInfos":customerInfos
                    });
                };
                this.sysApi.dispatchHook(OpenInventory, "craft");
            };
        }

        private function onExchangeMultiCraftRequest(role:int, otherName:String, askerId:int):void
        {
            var playedCharacterInfo:Object = this.playerApi.getPlayedCharacterInfo();
            if (askerId == playedCharacterInfo.id)
            {
                this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"), this.uiApi.getText("ui.craft.waitForCraftClient", otherName), [this.uiApi.getText("ui.common.cancel")], [this.sendActionCraftRefuse], null, this.sendActionCraftRefuse);
            }
            else
            {
                this._ignoreName = otherName;
                if (role == ExchangeTypeEnum.MULTICRAFT_CUSTOMER)
                {
                    this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"), this.uiApi.getText("ui.craft.CrafterAskCustomer", otherName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no"), this.uiApi.getText("ui.common.ignore")], [this.sendActionCraftAccept, this.sendActionCraftRefuse, this.sendActionIgnore], this.sendActionCraftAccept, this.sendActionCraftRefuse);
                }
                else
                {
                    if (role == ExchangeTypeEnum.MULTICRAFT_CRAFTER)
                    {
                        this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.exchange"), this.uiApi.getText("ui.craft.CustomerAskCrafter", otherName), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no"), this.uiApi.getText("ui.common.ignore")], [this.sendActionCraftAccept, this.sendActionCraftRefuse, this.sendActionIgnore], this.sendActionCraftAccept, this.sendActionCraftRefuse);
                    };
                };
            };
        }

        private function onJobLevelUp(jobName:String, newLevel:uint):void
        {
            if (!(this.uiApi.getUi("jobLevelUp")))
            {
                this.uiApi.loadUi("jobLevelUp", "jobLevelUp", {
                    "jobName":jobName,
                    "newLevel":newLevel
                });
            }
            else
            {
                this.uiApi.getUi("jobLevelUp").uiClass.onJobLevelUp(jobName, newLevel);
            };
        }

        private function onExchangeLeave(success:Boolean):void
        {
            if (this.uiApi.getUi(this._popupName))
            {
                this.uiApi.unloadUi(this._popupName);
            };
        }

        private function sendActionCraftAccept():void
        {
            this.sysApi.sendAction(new ExchangeAccept());
        }

        private function sendActionCraftRefuse():void
        {
            this.sysApi.sendAction(new ExchangeRefuse());
        }

        private function sendActionIgnore():void
        {
            this.sysApi.sendAction(new ExchangeRefuse());
            this.sysApi.sendAction(new AddIgnored(this._ignoreName));
        }

        public function onExchangeStartOkJobIndex(list:*):void
        {
            var job:*;
            var jobIds:Array = new Array();
            for each (job in list)
            {
                jobIds.push(job);
            };
            this.uiApi.loadUi("crafterList", "crafterList", jobIds);
        }


    }
}//package 

