package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.kernel.sound.enum.*;
    import com.ankamagames.dofus.kernel.sound.manager.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import flash.utils.*;

    public class SoundApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function SoundApi()
        {
            this._log = Log.getLogger(getQualifiedClassName());
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function activateSounds(param1:Boolean) : void
        {
            if (param1)
            {
                SoundManager.getInstance().setSoundOptions();
            }
            else
            {
                SoundManager.getInstance().setAmbienceVolume(0);
                SoundManager.getInstance().setMusicVolume(0);
                SoundManager.getInstance().setSoundVolume(0);
            }
            return;
        }// end function

        public function soundsAreActivated() : Boolean
        {
            return !OptionManager.getOptionManager("tubul")["tubulIsDesactivated"];
        }// end function

        public function updaterAvailable() : Boolean
        {
            return RegConnectionManager.getInstance().socketAvailable;
        }// end function

        public function setBusVolume(param1:uint, param2:uint) : void
        {
            return;
        }// end function

        public function playSoundById(param1:String) : void
        {
            SoundManager.getInstance().manager.playUISound(param1);
            return;
        }// end function

        public function fadeBusVolume(param1:uint, param2:Number, param3:uint) : void
        {
            return;
        }// end function

        public function playSound(param1:uint) : void
        {
            var _loc_2:Array = null;
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_5:String = null;
            var _loc_6:Array = null;
            var _loc_7:String = null;
            var _loc_8:Array = null;
            var _loc_9:String = null;
            switch(param1)
            {
                case SoundTypeEnum.OK_BUTTON:
                {
                    this.playSoundById(UISoundEnum.OK_BUTTON);
                    break;
                }
                case SoundTypeEnum.PLAY_BUTTON:
                {
                    this.playSoundById(UISoundEnum.PLAY_BUTTON);
                    break;
                }
                case SoundTypeEnum.GEN_BUTTON:
                {
                    this.playSoundById(UISoundEnum.GEN_BUTTON);
                    break;
                }
                case SoundTypeEnum.SPEC_BUTTON:
                {
                    this.playSoundById(UISoundEnum.SPEC_BUTTON);
                    break;
                }
                case SoundTypeEnum.CHECK_BUTTON_CHECKED:
                {
                    this.playSoundById(UISoundEnum.CHECKBOX_CHECKED);
                    break;
                }
                case SoundTypeEnum.CHECK_BUTTON_UNCHECKED:
                {
                    this.playSoundById(UISoundEnum.CHECKBOX_UNCHECKED);
                    break;
                }
                case SoundTypeEnum.DROP_START:
                {
                    this.playSoundById(UISoundEnum.DRAG_START);
                    break;
                }
                case SoundTypeEnum.DROP_END:
                {
                    this.playSoundById(UISoundEnum.DRAG_END);
                    break;
                }
                case SoundTypeEnum.TAB_BUTTON:
                {
                    this.playSoundById(UISoundEnum.TAB);
                    break;
                }
                case SoundTypeEnum.ROLLOVER:
                {
                    this.playSoundById(UISoundEnum.ROLLOVER);
                    break;
                }
                case SoundTypeEnum.POPUP_INFO:
                {
                    this.playSoundById(UISoundEnum.POPUP_INFO);
                    break;
                }
                case SoundTypeEnum.OPEN_WINDOW:
                {
                    this.playSoundById(UISoundEnum.WINDOW_OPEN);
                    break;
                }
                case SoundTypeEnum.CLOSE_WINDOW:
                {
                    this.playSoundById(UISoundEnum.WINDOW_CLOSE);
                    break;
                }
                case SoundTypeEnum.SCROLL_UP:
                {
                    this.playSoundById(UISoundEnum.SCROLL_UP);
                    break;
                }
                case SoundTypeEnum.SCROLL_DOWN:
                {
                    this.playSoundById(UISoundEnum.SCROLL_DOWN);
                    break;
                }
                case SoundTypeEnum.MAP_OPEN:
                {
                    this.playSoundById(UISoundEnum.MAP_OPEN);
                    break;
                }
                case SoundTypeEnum.MAP_CLOSE:
                {
                    this.playSoundById(UISoundEnum.MAP_CLOSE);
                    break;
                }
                case SoundTypeEnum.OPTIONS_OPEN:
                {
                    this.playSoundById(UISoundEnum.OPTIONS_OPEN);
                    break;
                }
                case SoundTypeEnum.OPTIONS_CLOSE:
                {
                    this.playSoundById(UISoundEnum.OPTIONS_CLOSE);
                    break;
                }
                case SoundTypeEnum.SOUND_SET:
                {
                    this.playSoundById(UISoundEnum.SOUND_SET);
                    break;
                }
                case SoundTypeEnum.INVENTORY_OPEN:
                {
                    this.playSoundById(UISoundEnum.OPEN_INVENTORY);
                    break;
                }
                case SoundTypeEnum.INVENTORY_CLOSE:
                {
                    this.playSoundById(UISoundEnum.CLOSE_INVENTORY);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_BOOT:
                {
                    this.playSoundById(UISoundEnum.EQUIP_BOOTS);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_CIRCLE:
                {
                    this.playSoundById(UISoundEnum.EQUIP_WRISTBAND);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_CLOTHES:
                {
                    _loc_2 = new Array(UISoundEnum.EQUIP_CLOTH_1, UISoundEnum.EQUIP_CLOTH_2, UISoundEnum.EQUIP_CLOTH_3, UISoundEnum.EQUIP_CLOTH_4, UISoundEnum.EQUIP_CLOTH_5);
                    _loc_3 = _loc_2[Math.round(Math.random() * (_loc_2.length - 1))];
                    this.playSoundById(_loc_3);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_NECKLACE:
                {
                    this.playSoundById(UISoundEnum.EQUIP_NECKLACE);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_ACCESSORIES:
                {
                    this.playSoundById(UISoundEnum.EQUIP_ACCESORIES);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_WEAPON:
                {
                    this.playSoundById(UISoundEnum.EQUIP_WEAPON);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_BUCKLER:
                {
                    this.playSoundById(UISoundEnum.EQUIP_HAND);
                    break;
                }
                case SoundTypeEnum.MOVE_ITEM_TO_BAG:
                {
                    _loc_4 = new Array(UISoundEnum.ITEM_IN_INVENTORY_1, UISoundEnum.ITEM_IN_INVENTORY_2, UISoundEnum.ITEM_IN_INVENTORY_3);
                    _loc_5 = _loc_4[Math.round(Math.random() * (_loc_4.length - 1))];
                    this.playSoundById(_loc_5);
                    break;
                }
                case SoundTypeEnum.DROP_ITEM:
                {
                    _loc_6 = new Array(UISoundEnum.DROP_ITEM_1, UISoundEnum.DROP_ITEM_2);
                    _loc_7 = _loc_6[Math.round(Math.random() * (_loc_6.length - 1))];
                    this.playSoundById(_loc_7);
                    break;
                }
                case SoundTypeEnum.GRIMOIRE_OPEN:
                {
                    this.playSoundById(UISoundEnum.OPEN_GRIMOIRE);
                    break;
                }
                case SoundTypeEnum.GRIMOIRE_CLOSE:
                {
                    this.playSoundById(UISoundEnum.CLOSE_GRIMOIRE);
                    break;
                }
                case SoundTypeEnum.CHARACTER_SHEET_OPEN:
                {
                    this.playSoundById(UISoundEnum.CHARACTER_SHEET_OPEN);
                    break;
                }
                case SoundTypeEnum.CHARACTER_SHEET_CLOSE:
                {
                    this.playSoundById(UISoundEnum.CHARACTER_SHEET_CLOSE);
                    break;
                }
                case SoundTypeEnum.LEVEL_UP:
                {
                    this.playSoundById(UISoundEnum.LEVEL_UP);
                    break;
                }
                case SoundTypeEnum.FIGHT_INTRO:
                {
                    this.playSoundById(UISoundEnum.INTRO_FIGHT);
                    break;
                }
                case SoundTypeEnum.FIGHT_OUTRO:
                {
                    this.playSoundById(UISoundEnum.OUTRO_FIGHT);
                    break;
                }
                case SoundTypeEnum.END_TURN:
                {
                    this.playSoundById(UISoundEnum.END_TURN);
                    break;
                }
                case SoundTypeEnum.READY_TO_FIGHT:
                {
                    this.playSoundById(UISoundEnum.READY_TO_FIGHT);
                    break;
                }
                case SoundTypeEnum.FIGHT_POSITION_SQUARE:
                {
                    this.playSoundById(UISoundEnum.FIGHT_POSITION);
                    break;
                }
                case SoundTypeEnum.CHARACTER_TURN:
                {
                    this.playSoundById(UISoundEnum.PLAYER_TURN);
                    break;
                }
                case SoundTypeEnum.NPC_TURN:
                {
                    this.playSoundById(UISoundEnum.NPC_TURN);
                    break;
                }
                case SoundTypeEnum.CHALLENGE_CHECKPOINT:
                {
                    this.playSoundById(UISoundEnum.CHALLENGE_CHECKPOINT);
                    break;
                }
                case SoundTypeEnum.LITTLE_OBJECTIVE:
                {
                    this.playSoundById(UISoundEnum.LITTLE_OBJECTIVE);
                    break;
                }
                case SoundTypeEnum.IMPORTANT_OBJECTIVE:
                {
                    this.playSoundById(UISoundEnum.IMPORTANT_OBJECTIVE);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_PET:
                {
                    this.playSoundById(UISoundEnum.EQUIP_PET);
                    break;
                }
                case SoundTypeEnum.EQUIPMENT_DOFUS:
                {
                    this.playSoundById(UISoundEnum.EQUIP_DOFUS);
                    break;
                }
                case SoundTypeEnum.SOCIAL_OPEN:
                {
                    this.playSoundById(UISoundEnum.FRIENDS);
                    break;
                }
                case SoundTypeEnum.MERCHANT_TRANSFERT_OPEN:
                {
                    this.playSoundById(UISoundEnum.OPEN_TRANSACTION_WINDOW);
                    break;
                }
                case SoundTypeEnum.MERCHANT_TRANSFERT_CLOSE:
                {
                    this.playSoundById(UISoundEnum.CLOSE_TRANSACTION_WINDOW);
                    break;
                }
                case SoundTypeEnum.SWITCH_RIGHT_TO_LEFT:
                {
                    this.playSoundById(UISoundEnum.RIGHT_TO_LEFT_SWITCH);
                    break;
                }
                case SoundTypeEnum.SWITCH_LEFT_TO_RIGHT:
                {
                    this.playSoundById(UISoundEnum.LEFT_TO_RIGHT_SWITCH);
                    break;
                }
                case SoundTypeEnum.DOCUMENT_OPEN:
                {
                    this.playSoundById(UISoundEnum.OPEN_DOCUMENT);
                    break;
                }
                case SoundTypeEnum.DOCUMENT_CLOSE:
                {
                    this.playSoundById(UISoundEnum.CLOSE_DOCUMENT);
                    break;
                }
                case SoundTypeEnum.DOCUMENT_TURN_PAGE:
                {
                    _loc_8 = new Array(UISoundEnum.TURN_PAGE_DOCUMENT_1, UISoundEnum.TURN_PAGE_DOCUMENT_2, UISoundEnum.TURN_PAGE_DOCUMENT_3, UISoundEnum.TURN_PAGE_DOCUMENT_4);
                    _loc_9 = _loc_8[Math.round(Math.random() * (_loc_8.length - 1))];
                    this.playSoundById(_loc_9);
                    break;
                }
                case SoundTypeEnum.DOCUMENT_BACK_FIRST_PAGE:
                {
                    this.playSoundById(UISoundEnum.BACK_TO_BEGINNING_DOCUMENT);
                    break;
                }
                case SoundTypeEnum.CHAT_GUILD_MESSAGE:
                {
                    this.playSoundById(UISoundEnum.GUILD_CHAT_MESSAGE);
                    break;
                }
                case SoundTypeEnum.OPEN_MOUNT_UI:
                {
                    this.playSoundById(UISoundEnum.OPEN_MOUNT_UI);
                    break;
                }
                case SoundTypeEnum.FIGHT_WIN:
                {
                    this.playSoundById(UISoundEnum.FIGHT_WIN);
                    break;
                }
                case SoundTypeEnum.FIGHT_LOSE:
                {
                    this.playSoundById(UISoundEnum.FIGHT_LOSE);
                    break;
                }
                case SoundTypeEnum.RECIPE_MATCH:
                {
                    this.playSoundById(UISoundEnum.RECIPE_MATCH);
                    break;
                }
                case SoundTypeEnum.NEW_TIPS:
                {
                    this.playSoundById(UISoundEnum.NEW_TIPS);
                    break;
                }
                case SoundTypeEnum.OPEN_CONTEXT_MENU:
                {
                    this.playSoundById(UISoundEnum.CONTEXT_MENU);
                    break;
                }
                case SoundTypeEnum.DELETE_CHARACTER:
                {
                    this.playSoundById(UISoundEnum.DELETE_CHARACTER);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function playLookSound(param1:String, param2:uint) : void
        {
            var look:String;
            var pLook:* = param1;
            var pSoundType:* = param2;
            try
            {
                look = pLook.split("||")[0];
                look = look.split("|")[1];
            }
            catch (e:Error)
            {
                _log.warn("The look (" + pLook + ") seems not to be OK :(");
                return;
            }
            var soundId:String;
            switch(int(look))
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
                {
                    soundId = soundId.concat("011");
                    break;
                }
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
                {
                    soundId = soundId.concat("012");
                    break;
                }
                case 30:
                {
                    soundId = soundId.concat("031");
                    break;
                }
                case 31:
                {
                    soundId = soundId.concat("032");
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(pSoundType)
            {
                case LookTypeSoundEnum.ATTACK:
                {
                    soundId = soundId.concat("01");
                    soundId = soundId.concat("00" + Math.round(Math.random() * 5 + 1).toString());
                    break;
                }
                case LookTypeSoundEnum.CHARACTER_SELECTION:
                {
                    soundId = soundId.concat("04001");
                    break;
                }
                case LookTypeSoundEnum.DEAD:
                {
                    soundId = soundId.concat("03");
                    soundId = soundId.concat("00" + Math.round(Math.random() * 2 + 1).toString());
                    break;
                }
                case LookTypeSoundEnum.HIT:
                {
                    soundId = soundId.concat("02");
                    soundId = soundId.concat("00" + Math.round(Math.random() * 6 + 1).toString());
                    break;
                }
                case LookTypeSoundEnum.LAUGH:
                {
                    soundId = soundId.concat("05");
                    soundId = soundId.concat("00" + Math.round(Math.random() * 6 + 1).toString());
                    break;
                }
                case LookTypeSoundEnum.RELIEF:
                {
                    soundId = soundId.concat("06001");
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.playSoundById(soundId);
            return;
        }// end function

        public function playIntroMusic() : void
        {
            SoundManager.getInstance().manager.playIntroMusic();
            return;
        }// end function

        public function switchIntroMusic(param1:Boolean = true) : void
        {
            SoundManager.getInstance().manager.switchIntroMusic(param1);
            return;
        }// end function

        public function stopIntroMusic() : void
        {
            SoundManager.getInstance().manager.stopIntroMusic();
            return;
        }// end function

        public function playSoundAtTurnStart() : Boolean
        {
            return OptionManager.getOptionManager("tubul")["playSoundAtTurnStart"];
        }// end function

        public function playSoundForGuildMessage() : Boolean
        {
            return OptionManager.getOptionManager("tubul")["playSoundForGuildMessage"];
        }// end function

    }
}
