package ui
{
    import d2api.BindsApi;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.SoundApi;
    import d2api.StorageApi;
    import d2api.TimeApi;
    import flash.geom.ColorTransform;
    import d2components.GraphicContainer;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.EntityDisplayer;
    import d2components.Texture;
    import d2hooks.MountSterilized;
    import d2hooks.MountUnSet;
    import d2hooks.MountRiding;
    import d2hooks.MountSet;
    import d2hooks.MountRenamed;
    import d2hooks.MountXpRatio;
    import d2enums.ShortcutHookListEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2enums.ProtocolConstantsEnum;
    import d2actions.MountRenameRequest;
    import d2actions.MountSetXpRatioRequest;
    import d2actions.ExchangeHandleMountStable;
    import d2actions.MountSterilizeRequest;
    import d2actions.MountReleaseRequest;
    import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
    import d2enums.StrataEnum;
    import d2hooks.TextInformation;
    import d2actions.ExchangeRequestOnMountStock;
    import d2actions.MountToggleRidingRequest;
    import d2hooks.OpenMountFeed;
    import d2hooks.*;
    import d2actions.*;

    public class MountInfo 
    {

        private static var _shortcutColor:String;

        public var bindsApi:BindsApi;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var soundApi:SoundApi;
        public var storageApi:StorageApi;
        public var timeApi:TimeApi;
        private var _currentMount:Object;
        private var _paddockMode:Boolean;
        private var _centeredMode:Boolean;
        private var _aLblCap:Array;
        private var _aLblEffect:Array;
        private var _serenityText:String;
        private var _playerMount:Boolean;
        private var _orangeColor:ColorTransform;
        private var _greenColor:ColorTransform;
        public var mainCtr:GraphicContainer;
        public var btn_changeName:ButtonContainer;
        public var btn_xp:ButtonContainer;
        public var btn_close:ButtonContainer;
        public var btn_sterilize:ButtonContainer;
        public var btn_release:ButtonContainer;
        public var btn_storage:ButtonContainer;
        public var btn_ancestors:ButtonContainer;
        public var btn_mount:ButtonContainer;
        public var btn_feed:ButtonContainer;
        public var btn_stat:ButtonContainer;
        public var btnstat:ButtonContainer;
        public var btn_effect:ButtonContainer;
        public var lbl_capacity:Label;
        public var lbl_btn_effect:Label;
        public var lbl_name:Label;
        public var lbl_type:Label;
        public var lbl_level:Label;
        public var lbl_sex:Label;
        public var lbl_mountable:Label;
        public var lbl_wild:Label;
        public var lbl_xpTitle:Label;
        public var lbl_xp:Label;
        public var lbl_reproduction:Label;
        public var lbl_fecondation:Label;
        public var lbl_title_fecondations:Label;
        public var tx_mount:EntityDisplayer;
        public var tx_progressBGEnergy:Texture;
        public var tx_progressBarEnergy:Texture;
        public var tx_progressBGXP:Texture;
        public var tx_progressBarXP:Texture;
        public var tx_progressBGTired:Texture;
        public var tx_progressBarTired:Texture;
        public var tx_progressBGReproduction:Texture;
        public var tx_progressBarReproduction:Texture;
        public var tx_progressBGLove:Texture;
        public var tx_progressBarLove:Texture;
        public var tx_progressBGMaturity:Texture;
        public var tx_progressBarMaturity:Texture;
        public var tx_progressBGStamina:Texture;
        public var tx_progressBarStamina:Texture;
        public var tx_progressBGSerenity:Texture;
        public var tx_progressBarSerenity:Texture;
        public var tx_sex:Texture;
        public var ctr_stat:GraphicContainer;
        public var ctr_capacity:GraphicContainer;
        public var ctr_effect:GraphicContainer;
        public var lbl_love:Label;
        public var lbl_maturity:Label;
        public var lbl_stamina:Label;
        public var tx_love:Texture;
        public var tx_maturity:Texture;
        public var tx_stamina:Texture;
        public var lbl_cap0:Label;
        public var lbl_cap1:Label;
        public var lbl_cap2:Label;
        public var lbl_cap3:Label;
        public var lbl_effect0:Label;
        public var lbl_effect1:Label;
        public var lbl_effect2:Label;
        public var lbl_effect3:Label;
        public var lbl_effect4:Label;
        public var lbl_effect5:Label;
        public var lbl_serenity:Label;


        public function main(param:Object):void
        {
            this.sysApi.addHook(MountSterilized, this.onMountSterilized);
            this.sysApi.addHook(MountUnSet, this.onMountUnSet);
            this.sysApi.addHook(MountRiding, this.onMountRiding);
            this.sysApi.addHook(MountSet, this.onMountSet);
            this.sysApi.addHook(MountRenamed, this.onMountRenamed);
            this.sysApi.addHook(MountXpRatio, this.onMountXpRatio);
            this.uiApi.addComponentHook(this.btn_changeName, "onRelease");
            this.uiApi.addComponentHook(this.btn_changeName, "onRollOver");
            this.uiApi.addComponentHook(this.btn_changeName, "onRollOut");
            this.uiApi.addComponentHook(this.btn_xp, "onRelease");
            this.uiApi.addComponentHook(this.btn_xp, "onRollOver");
            this.uiApi.addComponentHook(this.btn_xp, "onRollOut");
            this.uiApi.addComponentHook(this.btn_close, "onRelease");
            this.uiApi.addComponentHook(this.btn_stat, "onRelease");
            this.uiApi.addComponentHook(this.btn_effect, "onRelease");
            this.uiApi.addComponentHook(this.btn_release, "onRelease");
            this.uiApi.addComponentHook(this.btn_release, "onRollOver");
            this.uiApi.addComponentHook(this.btn_release, "onRollOut");
            this.uiApi.addComponentHook(this.btn_sterilize, "onRelease");
            this.uiApi.addComponentHook(this.btn_sterilize, "onRollOver");
            this.uiApi.addComponentHook(this.btn_sterilize, "onRollOut");
            this.uiApi.addComponentHook(this.btn_storage, "onRelease");
            this.uiApi.addComponentHook(this.btn_storage, "onRollOver");
            this.uiApi.addComponentHook(this.btn_storage, "onRollOut");
            this.uiApi.addComponentHook(this.btn_ancestors, "onRelease");
            this.uiApi.addComponentHook(this.btn_ancestors, "onRollOver");
            this.uiApi.addComponentHook(this.btn_ancestors, "onRollOut");
            this.uiApi.addComponentHook(this.btn_mount, "onRelease");
            this.uiApi.addComponentHook(this.btn_mount, "onRollOver");
            this.uiApi.addComponentHook(this.btn_mount, "onRollOut");
            this.uiApi.addComponentHook(this.btn_feed, "onRelease");
            this.uiApi.addComponentHook(this.btn_feed, "onRollOver");
            this.uiApi.addComponentHook(this.btn_feed, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_love, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_love, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_maturity, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_maturity, "onRollOut");
            this.uiApi.addComponentHook(this.lbl_stamina, "onRollOver");
            this.uiApi.addComponentHook(this.lbl_stamina, "onRollOut");
            this.uiApi.addComponentHook(this.tx_love, "onRollOver");
            this.uiApi.addComponentHook(this.tx_love, "onRollOut");
            this.uiApi.addComponentHook(this.tx_maturity, "onRollOver");
            this.uiApi.addComponentHook(this.tx_maturity, "onRollOut");
            this.uiApi.addComponentHook(this.tx_stamina, "onRollOver");
            this.uiApi.addComponentHook(this.tx_stamina, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBarEnergy, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBarEnergy, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBGEnergy, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBGEnergy, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBarLove, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBarLove, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBGLove, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBGLove, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBarMaturity, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBarMaturity, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBGMaturity, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBGMaturity, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBarXP, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBarXP, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBGXP, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBGXP, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBarSerenity, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBarSerenity, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBGSerenity, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBGSerenity, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBarStamina, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBarStamina, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBGStamina, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBGStamina, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBarTired, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBarTired, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBGTired, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBGTired, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBGReproduction, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBGReproduction, "onRollOut");
            this.uiApi.addComponentHook(this.tx_progressBarReproduction, "onRollOver");
            this.uiApi.addComponentHook(this.tx_progressBarReproduction, "onRollOut");
            this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI, this.onShortCut);
            this.soundApi.playSound(SoundTypeEnum.OPEN_MOUNT_UI);
            this.btn_sterilize.soundId = SoundEnum.MOUNT_HURT;
            this._aLblCap = [this.lbl_cap0, this.lbl_cap1, this.lbl_cap2, this.lbl_cap3];
            this._aLblEffect = [this.lbl_effect0, this.lbl_effect1, this.lbl_effect2, this.lbl_effect3, this.lbl_effect4, this.lbl_effect5];
            this._orangeColor = new ColorTransform(1, 1, 1, 1, 71, -50, -146);
            this._greenColor = new ColorTransform(1, 1, 1, 1, -100, 0, -175);
            this._paddockMode = param.paddockMode;
            this._centeredMode = param.centeredMode;
            var mountInfo:Object = this.uiApi.me();
            mountInfo.x = param.posX;
            mountInfo.y = param.posY;
            this.lbl_capacity.text = this.uiApi.processText(this.uiApi.getText("ui.common.capacity"), "m", false);
            this.lbl_btn_effect.text = this.uiApi.processText(this.uiApi.getText("ui.common.effects"), "m", false);
            this.btn_stat.selected = true;
            this.ctr_effect.visible = false;
            this.ctr_capacity.visible = true;
            if (this.playerApi.isIncarnation())
            {
                this.btn_mount.disabled = true;
            };
            if (this._paddockMode)
            {
                this.btn_close.visible = false;
                this.btn_mount.disabled = true;
                this.btn_storage.disabled = true;
                this.btn_xp.visible = false;
                this.btn_feed.disabled = false;
                this.uiApi.me().visible = false;
                this.btn_changeName.x = 340;
                this.btn_changeName.visible = false;
            }
            else
            {
                if (this._centeredMode)
                {
                    this.btn_mount.disabled = true;
                    this.btn_storage.disabled = true;
                    this.btn_sterilize.disabled = true;
                    this.btn_release.disabled = true;
                    this.btn_feed.disabled = false;
                    this.btn_xp.visible = false;
                    this.btn_changeName.visible = false;
                }
                else
                {
                    this.btn_mount.selected = this.playerApi.isRidding();
                };
            };
            if (!(this._paddockMode))
            {
                if (((this.playerApi.getMount()) && ((this.playerApi.getMount().id == param.mountData.id))))
                {
                    this.showMountInformation(param.mountData, MountPaddock.SOURCE_EQUIP);
                }
                else
                {
                    this.showMountInformation(param.mountData, MountPaddock.SOURCE_PADDOCK);
                };
            };
            this._currentMount = param.mountData;
        }

        public function showMountInformation(mount:Object, source:int):void
        {
            var lblcap:*;
            var lbleffect:*;
            var nEffect:int;
            this._currentMount = mount;
            MountPaddock._currentSource = source;
            switch (source)
            {
                case MountPaddock.SOURCE_EQUIP:
                case MountPaddock.SOURCE_BARN:
                    this.btn_changeName.visible = true;
                    break;
                case MountPaddock.SOURCE_PADDOCK:
                case MountPaddock.SOURCE_INVENTORY:
                    this.btn_changeName.visible = false;
                    break;
            };
            if (mount)
            {
                this.uiApi.me().visible = true;
                if (!(this._centeredMode))
                {
                    this.btn_sterilize.disabled = (this._currentMount.reproductionCount == -1);
                };
            };
            this.lbl_name.text = mount.name;
            this.lbl_type.text = mount.description;
            this.lbl_level.text = mount.level;
            this.lbl_serenity.text = mount.serenity;
            if (mount.sex)
            {
                this.tx_sex.uri = this.uiApi.createUri((this.uiApi.me().getConstant("assets") + "gestionDragodinde_tx_pictoFemelle"));
            }
            else
            {
                this.tx_sex.uri = this.uiApi.createUri((this.uiApi.me().getConstant("assets") + "gestionDragodinde_tx_pictoMale"));
            };
            if (mount.isRideable)
            {
                this.lbl_mountable.text = this.uiApi.getText("ui.common.yes");
            }
            else
            {
                this.lbl_mountable.text = this.uiApi.getText("ui.common.no");
            };
            if (mount.isWild)
            {
                this.lbl_wild.text = this.uiApi.getText("ui.common.yes");
            }
            else
            {
                this.lbl_wild.text = this.uiApi.getText("ui.common.no");
            };
            this._serenityText = ((((this._currentMount.aggressivityMax + "/") + this._currentMount.serenity) + "/") + this._currentMount.serenityMax);
            this.tx_mount.look = this._currentMount.entityLook;
            var playerMount:Object = this.playerApi.getMount();
            if (playerMount)
            {
                if (playerMount.id == this._currentMount.id)
                {
                    this._playerMount = true;
                }
                else
                {
                    this._playerMount = false;
                };
            }
            else
            {
                this._playerMount = false;
            };
            this.btn_feed.disabled = !((mount.maturity == mount.maturityForAdult));
            this.lbl_xp.visible = this._playerMount;
            this.lbl_xpTitle.visible = this._playerMount;
            this.btn_xp.visible = this._playerMount;
            this.tx_progressBarEnergy.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 68, -160, -160);
            this.tx_progressBarXP.transform.colorTransform = new ColorTransform(1, 1, 1, 1, -110, -66, 0);
            this.tx_progressBarTired.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 71, -50, -146);
            this.tx_progressBarReproduction.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 50, 40, -144);
            this.tx_progressBarEnergy.width = int(((mount.energy / mount.energyMax) * 180));
            this.tx_progressBarXP.width = int((((mount.experience - mount.experienceForLevel) / (mount.experienceForNextLevel - mount.experienceForLevel)) * 180));
            this.tx_progressBarTired.width = int(((mount.boostLimiter / mount.boostMax) * 180));
            if (mount.reproductionCount == -1)
            {
                this.lbl_reproduction.visible = true;
                this.lbl_reproduction.cssClass = "rightred";
                this.lbl_reproduction.text = this.uiApi.getText("ui.mount.castrated");
                this.tx_progressBarReproduction.visible = false;
                this.tx_progressBGReproduction.visible = false;
            }
            else
            {
                if (mount.reproductionCount == 20)
                {
                    this.lbl_reproduction.visible = true;
                    this.lbl_reproduction.cssClass = "rightred";
                    this.lbl_reproduction.text = this.uiApi.getText("ui.mount.sterilized");
                    this.tx_progressBarReproduction.visible = false;
                    this.tx_progressBGReproduction.visible = false;
                }
                else
                {
                    this.lbl_reproduction.visible = false;
                    this.tx_progressBarReproduction.visible = true;
                    this.tx_progressBGReproduction.visible = true;
                    this.tx_progressBarReproduction.width = int(((mount.reproductionCount / mount.reproductionCountMax) * 180));
                };
            };
            if (mount.fecondationTime > 0)
            {
                this.lbl_title_fecondations.visible = true;
                this.lbl_fecondation.visible = true;
                this.lbl_fecondation.cssClass = "rightblue";
                this.lbl_fecondation.text = (((((this.uiApi.getText("ui.mount.fecondee") + " (") + mount.fecondationTime) + " ") + this.uiApi.processText(this.uiApi.getText("ui.time.hours"), "m", (mount.fecondationTime == 1))) + ")");
            }
            else
            {
                if (mount.isFecondationReady)
                {
                    this.lbl_title_fecondations.visible = true;
                    this.lbl_fecondation.visible = true;
                    this.lbl_fecondation.cssClass = "rightgreen";
                    this.lbl_fecondation.text = this.uiApi.getText("ui.mount.fecondable");
                }
                else
                {
                    this.lbl_title_fecondations.visible = false;
                    this.lbl_fecondation.visible = false;
                };
            };
            this.lbl_xp.text = (mount.xpRatio + "%");
            this.tx_progressBarLove.width = int(((mount.love / mount.loveMax) * 175));
            if (mount.love >= (mount.loveMax * 0.75))
            {
                this.tx_progressBarLove.transform.colorTransform = this._greenColor;
            }
            else
            {
                this.tx_progressBarLove.transform.colorTransform = this._orangeColor;
            };
            this.tx_progressBarMaturity.width = int(((mount.maturity / mount.maturityForAdult) * 175));
            if (mount.maturity >= mount.maturityForAdult)
            {
                this.tx_progressBarMaturity.transform.colorTransform = this._greenColor;
            }
            else
            {
                this.tx_progressBarMaturity.transform.colorTransform = this._orangeColor;
            };
            this.tx_progressBarStamina.width = int(((mount.stamina / mount.staminaMax) * 175));
            if (mount.stamina >= (mount.staminaMax * 0.75))
            {
                this.tx_progressBarStamina.transform.colorTransform = this._greenColor;
            }
            else
            {
                this.tx_progressBarStamina.transform.colorTransform = this._orangeColor;
            };
            var agm:int = mount.aggressivityMax;
            this.tx_progressBarSerenity.width = int((((mount.serenity - agm) / (mount.serenityMax - agm)) * 241));
            if ((((mount.serenity >= -2000)) && ((mount.serenity <= 2000))))
            {
                this.tx_progressBarSerenity.transform.colorTransform = this._greenColor;
            }
            else
            {
                this.tx_progressBarSerenity.transform.colorTransform = this._orangeColor;
            };
            var nCapacity:int = mount.ability.length;
            var i:int;
            for each (lblcap in this._aLblCap)
            {
                lblcap.text = "";
            };
            if (nCapacity)
            {
                this.lbl_capacity.visible = true;
                this.ctr_capacity.visible = true;
                i = 0;
                while (i < nCapacity)
                {
                    this._aLblCap[i].text = ("• " + mount.ability[i].name);
                    i++;
                };
            }
            else
            {
                this.lbl_capacity.visible = false;
                this.ctr_capacity.visible = false;
            };
            for each (lbleffect in this._aLblEffect)
            {
                lbleffect.text = "";
            };
            nEffect = mount.effectList.length;
            if (nEffect)
            {
                i = 0;
                while (i < nEffect)
                {
                    this._aLblEffect[i].text = ("• " + mount.effectList[i].description);
                    i++;
                };
            }
            else
            {
                this._aLblEffect[0].text = ("• " + this.uiApi.processText(this.uiApi.getText("ui.common.lowerNone"), "m", true));
            };
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
        }

        private function onChangeName(value:String):void
        {
            if (value.length >= ProtocolConstantsEnum.MIN_RIDE_NAME_LEN)
            {
                this.sysApi.sendAction(new MountRenameRequest(value, this._currentMount.id));
            };
        }

        private function onValidXpRatio(qty:Number):void
        {
            this.sysApi.sendAction(new MountSetXpRatioRequest(qty));
        }

        private function onConfirmCutMount():void
        {
            if (this._paddockMode)
            {
                if (MountPaddock._currentSource == MountPaddock.SOURCE_EQUIP)
                {
                    this.sysApi.sendAction(new ExchangeHandleMountStable(18, this._currentMount.id));
                }
                else
                {
                    if (MountPaddock._currentSource == MountPaddock.SOURCE_BARN)
                    {
                        this.sysApi.sendAction(new ExchangeHandleMountStable(17, this._currentMount.id));
                    }
                    else
                    {
                        if (MountPaddock._currentSource == MountPaddock.SOURCE_PADDOCK)
                        {
                            this.sysApi.sendAction(new ExchangeHandleMountStable(19, this._currentMount.id));
                        };
                    };
                };
            }
            else
            {
                this.sysApi.sendAction(new MountSterilizeRequest());
            };
        }

        private function onConfirmKillMount():void
        {
            if (this._paddockMode)
            {
                if (MountPaddock._currentSource == MountPaddock.SOURCE_EQUIP)
                {
                    this.sysApi.sendAction(new ExchangeHandleMountStable(11, this._currentMount.id));
                }
                else
                {
                    if (MountPaddock._currentSource == MountPaddock.SOURCE_INVENTORY)
                    {
                        this.sysApi.sendAction(new ExchangeHandleMountStable(12, this._currentMount.id));
                    }
                    else
                    {
                        if (MountPaddock._currentSource == MountPaddock.SOURCE_BARN)
                        {
                            this.sysApi.sendAction(new ExchangeHandleMountStable(3, this._currentMount.id));
                        }
                        else
                        {
                            if (MountPaddock._currentSource == MountPaddock.SOURCE_PADDOCK)
                            {
                                this.sysApi.sendAction(new ExchangeHandleMountStable(8, this._currentMount.id));
                            };
                        };
                    };
                };
            }
            else
            {
                this.sysApi.sendAction(new MountReleaseRequest());
            };
        }

        private function onMountSterilized(id:Number):void
        {
            if (id == this._currentMount.id)
            {
                this.btn_sterilize.disabled = true;
                this.lbl_reproduction.text = this.uiApi.getText("ui.mount.castrated");
            };
        }

        private function onMountUnSet():void
        {
            if (!(this._paddockMode))
            {
                this.uiApi.unloadUi(this.uiApi.me().name);
            };
        }

        private function onMountRiding(isRiding:Boolean):void
        {
            this.btn_mount.selected = isRiding;
        }

        private function onMountRenamed(id:Number, name:String):void
        {
            if (id == this._currentMount.id)
            {
                this.lbl_name.text = name;
            };
        }

        private function onMountXpRatio(ratio:uint):void
        {
            this.lbl_xp.text = (ratio + "%");
        }

        public function onRollOver(target:Object):void
        {
            var param:Object;
            var data:Object;
            var textTooltip:String = "";
            var pos1:int = 6;
            var pos2:int;
            var offset:int;
            var shortcutKey:String;
            var ttWidth:uint;
            if (target == this.btn_xp)
            {
                textTooltip = this.uiApi.getText("ui.mount.xpPercentTooltip");
                pos1 = 7;
                pos2 = 1;
            }
            else
            {
                if (target == this.btn_changeName)
                {
                    textTooltip = this.uiApi.getText("ui.mount.renameTooltip");
                    pos1 = 7;
                    pos2 = 1;
                }
                else
                {
                    if (target == this.btn_mount)
                    {
                        textTooltip = this.uiApi.getText("ui.mount.rideTooltip");
                        pos1 = 7;
                        pos2 = 1;
                        shortcutKey = this.bindsApi.getShortcutBindStr("toggleRide");
                    }
                    else
                    {
                        if (target == this.btn_storage)
                        {
                            textTooltip = this.uiApi.getText("ui.mount.inventoryAccess");
                            shortcutKey = this.bindsApi.getShortcutBindStr("openMountStorage");
                            pos1 = 7;
                            pos2 = 1;
                        }
                        else
                        {
                            if (target == this.btn_ancestors)
                            {
                                textTooltip = this.uiApi.getText("ui.mount.ancestorTooltip");
                                pos1 = 7;
                                pos2 = 1;
                            }
                            else
                            {
                                if (target == this.btn_sterilize)
                                {
                                    textTooltip = this.uiApi.getText("ui.mount.castrateTooltip");
                                    pos1 = 7;
                                    pos2 = 1;
                                }
                                else
                                {
                                    if (target == this.btn_release)
                                    {
                                        textTooltip = this.uiApi.getText("ui.mount.killTooltip");
                                        pos1 = 7;
                                        pos2 = 1;
                                    }
                                    else
                                    {
                                        if (target == this.btn_feed)
                                        {
                                            textTooltip = this.uiApi.getText("ui.mount.feed");
                                            pos1 = 7;
                                            pos2 = 1;
                                        }
                                        else
                                        {
                                            if (target == this.lbl_love)
                                            {
                                                textTooltip = this.uiApi.getText("ui.mount.viewerTooltipLove");
                                                ttWidth = 300;
                                            }
                                            else
                                            {
                                                if (target == this.lbl_maturity)
                                                {
                                                    textTooltip = this.uiApi.getText("ui.mount.viewerTooltipMaturity");
                                                    ttWidth = 300;
                                                }
                                                else
                                                {
                                                    if (target == this.lbl_stamina)
                                                    {
                                                        textTooltip = this.uiApi.getText("ui.mount.viewerTooltipStamina");
                                                        ttWidth = 300;
                                                    }
                                                    else
                                                    {
                                                        if (target == this.tx_stamina)
                                                        {
                                                            textTooltip = this.uiApi.getText("ui.mount.viewerTooltipZone1");
                                                            pos1 = 1;
                                                            pos2 = 7;
                                                            offset = 10;
                                                            ttWidth = 300;
                                                        }
                                                        else
                                                        {
                                                            if (target == this.tx_maturity)
                                                            {
                                                                textTooltip = this.uiApi.getText("ui.mount.viewerToolTipZone2");
                                                                pos1 = 1;
                                                                pos2 = 7;
                                                                offset = 10;
                                                                ttWidth = 300;
                                                            }
                                                            else
                                                            {
                                                                if (target == this.tx_love)
                                                                {
                                                                    textTooltip = this.uiApi.getText("ui.mount.viewerTooltipZone3");
                                                                    pos1 = 1;
                                                                    pos2 = 7;
                                                                    offset = 10;
                                                                    ttWidth = 300;
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (!(this._currentMount))
            {
                return;
            };
            if ((((target == this.tx_progressBarEnergy)) || ((target == this.tx_progressBGEnergy))))
            {
                textTooltip = ((this._currentMount.energy + "/") + this._currentMount.energyMax);
            }
            else
            {
                if ((((target == this.tx_progressBarLove)) || ((target == this.tx_progressBGLove))))
                {
                    textTooltip = ((this._currentMount.love + "/") + this._currentMount.loveMax);
                }
                else
                {
                    if ((((target == this.tx_progressBarMaturity)) || ((target == this.tx_progressBGMaturity))))
                    {
                        textTooltip = ((this._currentMount.maturity + "/") + this._currentMount.maturityForAdult);
                    }
                    else
                    {
                        if ((((target == this.tx_progressBarSerenity)) || ((target == this.tx_progressBGSerenity))))
                        {
                            textTooltip = ((((this._currentMount.aggressivityMax + "/") + this._currentMount.serenity) + "/") + this._currentMount.serenityMax);
                        }
                        else
                        {
                            if ((((target == this.tx_progressBarStamina)) || ((target == this.tx_progressBGStamina))))
                            {
                                textTooltip = ((this._currentMount.stamina + "/") + this._currentMount.staminaMax);
                            }
                            else
                            {
                                if ((((target == this.tx_progressBarTired)) || ((target == this.tx_progressBGTired))))
                                {
                                    textTooltip = ((this._currentMount.boostLimiter + "/") + this._currentMount.boostMax);
                                }
                                else
                                {
                                    if ((((target == this.tx_progressBarReproduction)) || ((target == this.tx_progressBGReproduction))))
                                    {
                                        textTooltip = ((this._currentMount.reproductionCount + "/") + this._currentMount.reproductionCountMax);
                                    }
                                    else
                                    {
                                        if ((((target == this.tx_progressBarXP)) || ((target == this.tx_progressBGXP))))
                                        {
                                            textTooltip = ((this._currentMount.experience + "/") + this._currentMount.experienceForNextLevel);
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (textTooltip != "")
            {
                if (shortcutKey)
                {
                    if (!(_shortcutColor))
                    {
                        _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                        _shortcutColor = _shortcutColor.replace("0x", "#");
                    };
                    data = this.uiApi.textTooltipInfo((((((textTooltip + " <font color='") + _shortcutColor) + "'>(") + shortcutKey) + ")</font>"), null, null, ttWidth);
                }
                else
                {
                    data = this.uiApi.textTooltipInfo(textTooltip, null, null, ttWidth);
                };
                this.uiApi.showTooltip(data, target, false, "standard", pos1, pos2, offset, null, null, null, "TextInfo");
            };
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_changeName:
                    this.modCommon.openInputPopup(this.uiApi.getText("ui.mount.renameTooltip"), this.uiApi.getText("ui.mount.popupRename"), this.onChangeName, null, this._currentMount.name, "A-Za-z", ProtocolConstantsEnum.MAX_RIDE_NAME_LEN);
                    break;
                case this.btn_xp:
                    this.modCommon.openQuantityPopup(0, 90, this._currentMount.xpRatio, this.onValidXpRatio);
                    break;
                case this.btn_close:
                    this.uiApi.unloadUi(this.uiApi.me().name);
                    break;
                case this.btn_sterilize:
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.mount.doUCastrateYourMount"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmCutMount, null]);
                    break;
                case this.btn_release:
                    this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.mount.doUKillYourMount"), [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onConfirmKillMount, null], this.onConfirmKillMount, function ():void
                    {
                    });
                    break;
                case this.btn_ancestors:
                    if (!(this.uiApi.getUi(UIEnum.MOUNT_ANCESTORS)))
                    {
                        this.uiApi.loadUi(UIEnum.MOUNT_ANCESTORS, UIEnum.MOUNT_ANCESTORS, {"mount":this._currentMount}, StrataEnum.STRATA_HIGH);
                    };
                    break;
                case this.btn_storage:
                    if (this.playerApi.isInFight())
                    {
                        this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.error.cantDoInFight"), 666, this.timeApi.getTimestamp());
                    }
                    else
                    {
                        this.sysApi.sendAction(new ExchangeRequestOnMountStock());
                    };
                    break;
                case this.btn_mount:
                    this.sysApi.sendAction(new MountToggleRidingRequest());
                    this.btn_mount.selected = false;
                    break;
                case this.btn_feed:
                    this.initFeed();
                    break;
                case this.btn_stat:
                    this.ctr_stat.visible = true;
                    this.ctr_capacity.visible = true;
                    this.ctr_effect.visible = false;
                    break;
                case this.btn_effect:
                    this.ctr_stat.visible = false;
                    this.ctr_capacity.visible = true;
                    this.ctr_effect.visible = true;
                    break;
            };
        }

        private function initFeed():void
        {
            var foodList:Object;
            if ((((((MountPaddock._currentSource == MountPaddock.SOURCE_EQUIP)) || ((MountPaddock._currentSource == MountPaddock.SOURCE_BARN)))) && (((!(this.playerApi.isInFight())) || (this.playerApi.isInPreFight())))))
            {
                foodList = this.storageApi.getRideFoods();
                if (foodList.length)
                {
                    this.sysApi.dispatchHook(OpenMountFeed, this._currentMount.id, MountPaddock._currentSource, foodList);
                }
                else
                {
                    this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), this.uiApi.getText("ui.item.errorNoFoodMount"), [this.uiApi.getText("ui.common.ok")]);
                };
            }
            else
            {
                this.sysApi.dispatchHook(TextInformation, this.uiApi.getText("ui.mount.impossibleFeed"), 666, this.timeApi.getTimestamp());
            };
        }

        private function onMountSet():void
        {
            this.showMountInformation(this.playerApi.getMount(), MountPaddock.SOURCE_EQUIP);
        }

        private function onShortCut(s:String):Boolean
        {
            if (s == ShortcutHookListEnum.CLOSE_UI)
            {
                if (this._paddockMode)
                {
                    return (false);
                };
                this.uiApi.unloadUi(this.uiApi.me().name);
                return (true);
            };
            return (false);
        }


    }
}//package ui

