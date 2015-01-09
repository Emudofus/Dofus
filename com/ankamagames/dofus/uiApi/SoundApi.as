package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.dofus.kernel.sound.manager.RegConnectionManager;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.frames.LoadingModuleFrame;
    import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
    import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
    import com.ankamagames.dofus.kernel.sound.enum.LookTypeSoundEnum;

    [InstanciedApi]
    public class SoundApi implements IApi 
    {

        protected var _log:Logger;
        private var _module:UiModule;

        public function SoundApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(SoundApi));
            super();
        }

        [ApiData(name="module")]
        public function set module(value:UiModule):void
        {
            this._module = value;
        }

        [Trusted]
        public function destroy():void
        {
            this._module = null;
        }

        [Untrusted]
        public function activateSounds(pActivate:Boolean):void
        {
            if (pActivate)
            {
                SoundManager.getInstance().setSoundOptions();
            }
            else
            {
                SoundManager.getInstance().setAmbienceVolume(0);
                SoundManager.getInstance().setMusicVolume(0);
                SoundManager.getInstance().setSoundVolume(0);
            };
        }

        [Untrusted]
        public function soundsAreActivated():Boolean
        {
            return (!(OptionManager.getOptionManager("tubul")["tubulIsDesactivated"]));
        }

        [Untrusted]
        public function updaterAvailable():Boolean
        {
            return (RegConnectionManager.getInstance().socketAvailable);
        }

        [Untrusted]
        public function setBusVolume(pAudioBusId:uint, pVolume:uint):void
        {
        }

        [Untrusted]
        public function playSoundById(pSoundId:String):void
        {
            var loadingFrame:LoadingModuleFrame = (Kernel.getWorker().getFrame(LoadingModuleFrame) as LoadingModuleFrame);
            if (!(loadingFrame))
            {
                SoundManager.getInstance().manager.playUISound(pSoundId);
            };
        }

        [Untrusted]
        public function fadeBusVolume(pBusId:uint, pFade:Number, pFadeTime:uint):void
        {
        }

        [Untrusted]
        public function playSound(pSound:uint):void
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:Array;
            var _local_5:String;
            var _local_6:Array;
            var _local_7:String;
            var _local_8:Array;
            var _local_9:String;
            switch (pSound)
            {
                case SoundTypeEnum.OK_BUTTON:
                    this.playSoundById(UISoundEnum.OK_BUTTON);
                    return;
                case SoundTypeEnum.PLAY_BUTTON:
                    this.playSoundById(UISoundEnum.PLAY_BUTTON);
                    return;
                case SoundTypeEnum.GEN_BUTTON:
                    this.playSoundById(UISoundEnum.GEN_BUTTON);
                    return;
                case SoundTypeEnum.SPEC_BUTTON:
                    this.playSoundById(UISoundEnum.SPEC_BUTTON);
                    return;
                case SoundTypeEnum.CHECK_BUTTON_CHECKED:
                    this.playSoundById(UISoundEnum.CHECKBOX_CHECKED);
                    return;
                case SoundTypeEnum.CHECK_BUTTON_UNCHECKED:
                    this.playSoundById(UISoundEnum.CHECKBOX_UNCHECKED);
                    return;
                case SoundTypeEnum.DROP_START:
                    this.playSoundById(UISoundEnum.DRAG_START);
                    return;
                case SoundTypeEnum.DROP_END:
                    this.playSoundById(UISoundEnum.DRAG_END);
                    return;
                case SoundTypeEnum.TAB_BUTTON:
                    this.playSoundById(UISoundEnum.TAB);
                    return;
                case SoundTypeEnum.ROLLOVER:
                    this.playSoundById(UISoundEnum.ROLLOVER);
                    return;
                case SoundTypeEnum.POPUP_INFO:
                    this.playSoundById(UISoundEnum.POPUP_INFO);
                    return;
                case SoundTypeEnum.OPEN_WINDOW:
                    this.playSoundById(UISoundEnum.WINDOW_OPEN);
                    return;
                case SoundTypeEnum.CLOSE_WINDOW:
                    this.playSoundById(UISoundEnum.WINDOW_CLOSE);
                    return;
                case SoundTypeEnum.SCROLL_UP:
                    this.playSoundById(UISoundEnum.SCROLL_UP);
                    return;
                case SoundTypeEnum.SCROLL_DOWN:
                    this.playSoundById(UISoundEnum.SCROLL_DOWN);
                    return;
                case SoundTypeEnum.MAP_OPEN:
                    this.playSoundById(UISoundEnum.MAP_OPEN);
                    return;
                case SoundTypeEnum.MAP_CLOSE:
                    this.playSoundById(UISoundEnum.MAP_CLOSE);
                    return;
                case SoundTypeEnum.OPTIONS_OPEN:
                    this.playSoundById(UISoundEnum.OPTIONS_OPEN);
                    return;
                case SoundTypeEnum.OPTIONS_CLOSE:
                    this.playSoundById(UISoundEnum.OPTIONS_CLOSE);
                    return;
                case SoundTypeEnum.SOUND_SET:
                    this.playSoundById(UISoundEnum.SOUND_SET);
                    return;
                case SoundTypeEnum.INVENTORY_OPEN:
                    this.playSoundById(UISoundEnum.OPEN_INVENTORY);
                    return;
                case SoundTypeEnum.INVENTORY_CLOSE:
                    this.playSoundById(UISoundEnum.CLOSE_INVENTORY);
                    return;
                case SoundTypeEnum.EQUIPMENT_BOOT:
                    this.playSoundById(UISoundEnum.EQUIP_BOOTS);
                    return;
                case SoundTypeEnum.EQUIPMENT_CIRCLE:
                    this.playSoundById(UISoundEnum.EQUIP_WRISTBAND);
                    return;
                case SoundTypeEnum.EQUIPMENT_CLOTHES:
                    _local_2 = new Array(UISoundEnum.EQUIP_CLOTH_1, UISoundEnum.EQUIP_CLOTH_2, UISoundEnum.EQUIP_CLOTH_3, UISoundEnum.EQUIP_CLOTH_4, UISoundEnum.EQUIP_CLOTH_5);
                    _local_3 = _local_2[Math.round((Math.random() * (_local_2.length - 1)))];
                    this.playSoundById(_local_3);
                    return;
                case SoundTypeEnum.EQUIPMENT_NECKLACE:
                    this.playSoundById(UISoundEnum.EQUIP_NECKLACE);
                    return;
                case SoundTypeEnum.EQUIPMENT_ACCESSORIES:
                    this.playSoundById(UISoundEnum.EQUIP_ACCESORIES);
                    return;
                case SoundTypeEnum.EQUIPMENT_WEAPON:
                    this.playSoundById(UISoundEnum.EQUIP_WEAPON);
                    return;
                case SoundTypeEnum.EQUIPMENT_BUCKLER:
                    this.playSoundById(UISoundEnum.EQUIP_HAND);
                    return;
                case SoundTypeEnum.MOVE_ITEM_TO_BAG:
                    _local_4 = new Array(UISoundEnum.ITEM_IN_INVENTORY_1, UISoundEnum.ITEM_IN_INVENTORY_2, UISoundEnum.ITEM_IN_INVENTORY_3);
                    _local_5 = _local_4[Math.round((Math.random() * (_local_4.length - 1)))];
                    this.playSoundById(_local_5);
                    return;
                case SoundTypeEnum.DROP_ITEM:
                    _local_6 = new Array(UISoundEnum.DROP_ITEM_1, UISoundEnum.DROP_ITEM_2);
                    _local_7 = _local_6[Math.round((Math.random() * (_local_6.length - 1)))];
                    this.playSoundById(_local_7);
                    return;
                case SoundTypeEnum.GRIMOIRE_OPEN:
                    this.playSoundById(UISoundEnum.OPEN_GRIMOIRE);
                    return;
                case SoundTypeEnum.GRIMOIRE_CLOSE:
                    this.playSoundById(UISoundEnum.CLOSE_GRIMOIRE);
                    return;
                case SoundTypeEnum.CHARACTER_SHEET_OPEN:
                    this.playSoundById(UISoundEnum.CHARACTER_SHEET_OPEN);
                    return;
                case SoundTypeEnum.CHARACTER_SHEET_CLOSE:
                    this.playSoundById(UISoundEnum.CHARACTER_SHEET_CLOSE);
                    return;
                case SoundTypeEnum.LEVEL_UP:
                    this.playSoundById(UISoundEnum.LEVEL_UP);
                    return;
                case SoundTypeEnum.FIGHT_INTRO:
                    this.playSoundById(UISoundEnum.INTRO_FIGHT);
                    return;
                case SoundTypeEnum.FIGHT_OUTRO:
                    this.playSoundById(UISoundEnum.OUTRO_FIGHT);
                    return;
                case SoundTypeEnum.END_TURN:
                    this.playSoundById(UISoundEnum.END_TURN);
                    return;
                case SoundTypeEnum.READY_TO_FIGHT:
                    this.playSoundById(UISoundEnum.READY_TO_FIGHT);
                    return;
                case SoundTypeEnum.FIGHT_POSITION_SQUARE:
                    this.playSoundById(UISoundEnum.FIGHT_POSITION);
                    return;
                case SoundTypeEnum.CHARACTER_TURN:
                    this.playSoundById(UISoundEnum.PLAYER_TURN);
                    return;
                case SoundTypeEnum.NPC_TURN:
                    this.playSoundById(UISoundEnum.NPC_TURN);
                    return;
                case SoundTypeEnum.CHALLENGE_CHECKPOINT:
                    this.playSoundById(UISoundEnum.CHALLENGE_CHECKPOINT);
                    return;
                case SoundTypeEnum.LITTLE_OBJECTIVE:
                    this.playSoundById(UISoundEnum.LITTLE_OBJECTIVE);
                    return;
                case SoundTypeEnum.IMPORTANT_OBJECTIVE:
                    this.playSoundById(UISoundEnum.IMPORTANT_OBJECTIVE);
                    return;
                case SoundTypeEnum.EQUIPMENT_PET:
                    this.playSoundById(UISoundEnum.EQUIP_PET);
                    return;
                case SoundTypeEnum.EQUIPMENT_DOFUS:
                    this.playSoundById(UISoundEnum.EQUIP_DOFUS);
                    return;
                case SoundTypeEnum.SOCIAL_OPEN:
                    this.playSoundById(UISoundEnum.FRIENDS);
                    return;
                case SoundTypeEnum.MERCHANT_TRANSFERT_OPEN:
                    this.playSoundById(UISoundEnum.OPEN_TRANSACTION_WINDOW);
                    return;
                case SoundTypeEnum.MERCHANT_TRANSFERT_CLOSE:
                    this.playSoundById(UISoundEnum.CLOSE_TRANSACTION_WINDOW);
                    return;
                case SoundTypeEnum.SWITCH_RIGHT_TO_LEFT:
                    this.playSoundById(UISoundEnum.RIGHT_TO_LEFT_SWITCH);
                    return;
                case SoundTypeEnum.SWITCH_LEFT_TO_RIGHT:
                    this.playSoundById(UISoundEnum.LEFT_TO_RIGHT_SWITCH);
                    return;
                case SoundTypeEnum.DOCUMENT_OPEN:
                    this.playSoundById(UISoundEnum.OPEN_DOCUMENT);
                    return;
                case SoundTypeEnum.DOCUMENT_CLOSE:
                    this.playSoundById(UISoundEnum.CLOSE_DOCUMENT);
                    return;
                case SoundTypeEnum.DOCUMENT_TURN_PAGE:
                    _local_8 = new Array(UISoundEnum.TURN_PAGE_DOCUMENT_1, UISoundEnum.TURN_PAGE_DOCUMENT_2, UISoundEnum.TURN_PAGE_DOCUMENT_3, UISoundEnum.TURN_PAGE_DOCUMENT_4);
                    _local_9 = _local_8[Math.round((Math.random() * (_local_8.length - 1)))];
                    this.playSoundById(_local_9);
                    return;
                case SoundTypeEnum.DOCUMENT_BACK_FIRST_PAGE:
                    this.playSoundById(UISoundEnum.BACK_TO_BEGINNING_DOCUMENT);
                    return;
                case SoundTypeEnum.CHAT_GUILD_MESSAGE:
                    this.playSoundById(UISoundEnum.GUILD_CHAT_MESSAGE);
                    return;
                case SoundTypeEnum.OPEN_MOUNT_UI:
                    this.playSoundById(UISoundEnum.OPEN_MOUNT_UI);
                    return;
                case SoundTypeEnum.FIGHT_WIN:
                    this.playSoundById(UISoundEnum.FIGHT_WIN);
                    return;
                case SoundTypeEnum.FIGHT_LOSE:
                    this.playSoundById(UISoundEnum.FIGHT_LOSE);
                    return;
                case SoundTypeEnum.RECIPE_MATCH:
                    this.playSoundById(UISoundEnum.RECIPE_MATCH);
                    return;
                case SoundTypeEnum.NEW_TIPS:
                    this.playSoundById(UISoundEnum.NEW_TIPS);
                    return;
                case SoundTypeEnum.OPEN_CONTEXT_MENU:
                    this.playSoundById(UISoundEnum.CONTEXT_MENU);
                    return;
                case SoundTypeEnum.DELETE_CHARACTER:
                    this.playSoundById(UISoundEnum.DELETE_CHARACTER);
                    return;
            };
        }

        [Untrusted]
        public function playLookSound(pLook:String, pSoundType:uint):void
        {
            var look:String;
            try
            {
                look = pLook.split("||")[0];
                look = look.split("|")[1];
            }
            catch(e:Error)
            {
                _log.warn((("The look (" + pLook) + ") seems not to be OK :("));
                return;
            };
            var soundId:String = "21";
            switch (int(look))
            {
                case 10:
                case 20:
                case 40:
                case 50:
                case 60:
                case 70:
                case 80:
                case 90:
                case 100:
                case 110:
                case 120:
                    soundId = soundId.concat("011");
                    break;
                case 11:
                case 21:
                case 41:
                case 51:
                case 61:
                case 71:
                case 81:
                case 91:
                case 101:
                case 111:
                case 121:
                    soundId = soundId.concat("012");
                    break;
                case 30:
                    soundId = soundId.concat("031");
                    break;
                case 31:
                    soundId = soundId.concat("032");
                    break;
            };
            switch (pSoundType)
            {
                case LookTypeSoundEnum.ATTACK:
                    soundId = soundId.concat("01");
                    soundId = soundId.concat(("00" + Math.round(((Math.random() * 5) + 1)).toString()));
                    break;
                case LookTypeSoundEnum.CHARACTER_SELECTION:
                    soundId = soundId.concat("04001");
                    break;
                case LookTypeSoundEnum.DEAD:
                    soundId = soundId.concat("03");
                    soundId = soundId.concat(("00" + Math.round(((Math.random() * 2) + 1)).toString()));
                    break;
                case LookTypeSoundEnum.HIT:
                    soundId = soundId.concat("02");
                    soundId = soundId.concat(("00" + Math.round(((Math.random() * 6) + 1)).toString()));
                    break;
                case LookTypeSoundEnum.LAUGH:
                    soundId = soundId.concat("05");
                    soundId = soundId.concat(("00" + Math.round(((Math.random() * 6) + 1)).toString()));
                    break;
                case LookTypeSoundEnum.RELIEF:
                    soundId = soundId.concat("06001");
                    break;
            };
            this.playSoundById(soundId);
        }

        [Trusted]
        public function playIntroMusic():void
        {
            SoundManager.getInstance().manager.playIntroMusic();
        }

        [Trusted]
        public function switchIntroMusic(pFirstHarmonic:Boolean=true):void
        {
            SoundManager.getInstance().manager.switchIntroMusic(pFirstHarmonic);
        }

        [Trusted]
        public function stopIntroMusic():void
        {
            SoundManager.getInstance().manager.stopIntroMusic();
        }

        [Untrusted]
        public function playSoundAtTurnStart():Boolean
        {
            return (OptionManager.getOptionManager("tubul")["playSoundAtTurnStart"]);
        }

        [Untrusted]
        public function playSoundForGuildMessage():Boolean
        {
            return (OptionManager.getOptionManager("tubul")["playSoundForGuildMessage"]);
        }


    }
}//package com.ankamagames.dofus.uiApi

