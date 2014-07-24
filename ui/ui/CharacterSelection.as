package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SoundApi;
   import d2api.DataApi;
   import d2api.SecurityApi;
   import d2api.ConnectionApi;
   import d2components.GraphicContainer;
   import d2components.Texture;
   import d2components.Label;
   import d2components.CharacterWheel;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.*;
   import d2actions.*;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2data.SubArea;
   import d2data.Pack;
   
   public class CharacterSelection extends Object
   {
      
      public function CharacterSelection() {
         this._cbProvider = new Array();
         super();
      }
      
      private static const DEATH_STATE_ALIVE:uint = 0;
      
      private static const DEATH_STATE_DEAD:uint = 1;
      
      private static const DEATH_STATE_WAITING_CONFIRMATION:uint = 2;
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var soundApi:SoundApi;
      
      public var modCommon:Object;
      
      public var dataApi:DataApi;
      
      public var securityApi:SecurityApi;
      
      public var connectionApi:ConnectionApi;
      
      private var _aCharactersList:Object;
      
      private var _nbCharacters:uint;
      
      private var _cbProvider:Array;
      
      private var _askToDelete:Boolean = false;
      
      private var _lockPopup:String;
      
      public var charaSelCtr:GraphicContainer;
      
      public var midZCtr:GraphicContainer;
      
      public var frontZCtr:GraphicContainer;
      
      public var hardcoreCtr:GraphicContainer;
      
      public var ctr_extendedList:GraphicContainer;
      
      public var titleCharSelection:Object;
      
      public var tx_deathCounter:Texture;
      
      public var tx_bonusXp:Texture;
      
      public var tx_bonusXpCreation:Texture;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var lbl_deathCounter:Label;
      
      public var lbl_unusableCharacter:Label;
      
      public var charaWheel:CharacterWheel;
      
      public var characCb:Object;
      
      public var grid_character:Grid;
      
      public var lbl_List:Label;
      
      public var btn_play:ButtonContainer;
      
      public var btn_cross:ButtonContainer;
      
      public var btn_create:ButtonContainer;
      
      public var btn_changeServer:ButtonContainer;
      
      public var btn_resetCharacter:ButtonContainer;
      
      public var btn_bigArrowLeft:ButtonContainer;
      
      public var btn_bigArrowRight:ButtonContainer;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public function main(charaList:Object) : void {
         this.soundApi.switchIntroMusic(false);
         this.btn_bigArrowRight.isMute = true;
         this.btn_bigArrowLeft.isMute = true;
         this.btn_changeServer.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_create.soundId = SoundEnum.OK_BUTTON;
         this.btn_rightArrow.soundId = SoundEnum.SCROLL_UP;
         this.btn_leftArrow.soundId = SoundEnum.SCROLL_DOWN;
         this.btn_play.isMute = true;
         this.sysApi.addHook(CharactersListUpdated,this.onCharactersListUpdated);
         this.sysApi.addHook(CharacterDeletionError,this.onCharacterDeletionError);
         this.sysApi.addHook(CharacterImpossibleSelection,this.onCharacterImpossibleSelection);
         this.sysApi.addHook(PackRestrictedSubArea,this.onPackRestrictedSubArea);
         this.sysApi.addHook(DownloadError,this.onDownloadError);
         this.uiApi.addComponentHook(this.grid_character,"onSelectItem");
         this.uiApi.addComponentHook(this.tx_bonusXp,"onRollOver");
         this.uiApi.addComponentHook(this.tx_bonusXp,"onRollOut");
         this.uiApi.addComponentHook(this.tx_bonusXpCreation,"onRollOver");
         this.uiApi.addComponentHook(this.tx_bonusXpCreation,"onRollOut");
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("rightArrow",this.onShortcut);
         this.uiApi.addShortcutHook("leftArrow",this.onShortcut);
         this._aCharactersList = new Array();
         if(!this.sysApi.isCharacterCreationAllowed())
         {
            this.btn_changeServer.disabled = true;
            this.btn_create.disabled = true;
            this.btn_cross.disabled = true;
         }
         this.onCharactersListUpdated(charaList);
         if((!((this.sysApi.hasPart("all")) && (this.sysApi.hasPart("subscribed")))) && (!this.sysApi.hasUpdaterConnection()) && (!(!this.sysApi.getBuildType() == 4)))
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.streaming.noupdater"),[this.uiApi.getText("ui.common.ok")]);
         }
      }
      
      public function unload() : void {
      }
      
      private function getIdCharByNumber(n:uint) : uint {
         return this._aCharactersList[n].id;
      }
      
      private function rotateMountains(sens:int) : void {
         if(sens != 0)
         {
            this.charaWheel.wheel(sens);
            this.updateSelectedCharacter();
         }
      }
      
      private function updateSelectedCharacter() : void {
         var index:* = 0;
         var server:Object = null;
         var deathCount:uint = 0;
         var deathState:uint = 0;
         if(this._nbCharacters != 0)
         {
            index = this.getSelectedCharacterIndex();
            this.lbl_name.text = this._aCharactersList[index].name;
            this.lbl_level.text = this.uiApi.getText("ui.common.level") + this.uiApi.getText("ui.common.colon") + this._aCharactersList[index].level.toString();
            this.tx_bonusXp.gotoAndStop = this._aCharactersList[index].bonusXp.toString();
            if(this._aCharactersList[index].bonusXp == 1)
            {
               this.tx_bonusXp.visible = false;
            }
            else
            {
               this.tx_bonusXp.visible = true;
            }
            server = this.sysApi.getCurrentServer();
            if(server.gameTypeId == 0)
            {
               this.btn_play.disabled = false;
               this.hardcoreCtr.visible = false;
            }
            else
            {
               deathCount = this._aCharactersList[index].deathCount;
               deathState = this._aCharactersList[index].deathState;
               if(deathState == DEATH_STATE_ALIVE)
               {
                  this.btn_play.disabled = false;
                  this.hardcoreCtr.visible = false;
               }
               else
               {
                  this.btn_play.disabled = true;
                  this.hardcoreCtr.visible = true;
                  this.tx_deathCounter.gotoAndStop = deathCount > 11?12:deathCount + 1;
                  this.lbl_deathCounter.text = "x " + deathCount;
               }
            }
            if(this._aCharactersList[index].unusable)
            {
               this.lbl_unusableCharacter.visible = true;
            }
            else
            {
               this.lbl_unusableCharacter.visible = false;
            }
         }
      }
      
      private function validateCharacterChoice(i:int) : void {
         var server:Object = null;
         var deathState:uint = 0;
         if(this._nbCharacters != 0)
         {
            if(!this.charaWheel.isWheeling)
            {
               server = this.sysApi.getCurrentServer();
               if((this.securityApi.SecureModeisActive()) && (this.connectionApi.isCharacterWaitingForChange(this.getIdCharByNumber(i))))
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.characterToBeModifiedForbidden"),[this.uiApi.getText("ui.common.ok")]);
               }
               else
               {
                  if((server.gameTypeId == 1) || (server.gameTypeId == 4))
                  {
                     deathState = this._aCharactersList[this.getSelectedCharacterIndex()].deathState;
                     if(deathState != DEATH_STATE_ALIVE)
                     {
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.resetCharacter"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onPopupReset,this.onPopupClose],this.onPopupReset,this.onPopupClose);
                        return;
                     }
                  }
                  this.btn_play.disabled = true;
                  this.sysApi.sendAction(new d2actions.CharacterSelection(this.getIdCharByNumber(i),false));
                  this.soundApi.playSound(SoundTypeEnum.PLAY_BUTTON);
               }
            }
         }
      }
      
      public function updateCharacterLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            if(data.character.bonusXp > 1)
            {
               componentsRef.tx_gridBonusXp.gotoAndStop = data.character.bonusXp.toString();
               componentsRef.lbl_gridName.width = 257;
            }
            else
            {
               componentsRef.tx_gridBonusXp.gotoAndStop = "1";
               componentsRef.lbl_gridName.width = 277;
            }
            componentsRef.lbl_gridName.text = data.label;
            componentsRef.btn_gridCharacter.selected = selected;
         }
         else
         {
            componentsRef.lbl_gridName.text = "";
            componentsRef.btn_gridCharacter.selected = false;
            componentsRef.tx_gridBonusXp.gotoAndStop = "1";
         }
      }
      
      public function onRelease(target:Object) : void {
         var nbCharacters:* = 0;
         var i:* = 0;
         var t:* = NaN;
         var sens:* = 0;
         switch(target)
         {
            case this.btn_play:
            case this.btn_resetCharacter:
               this.validateCharacterChoice(this.getSelectedCharacterIndex());
               break;
            case this.btn_cross:
               this._askToDelete = true;
               if((this._aCharactersList[this.getSelectedCharacterIndex()].level >= 20) && (!(this.sysApi.getPlayerManager().secretQuestion == "")))
               {
                  this.uiApi.loadUi("secretPopup","secretPopup",[this.getIdCharByNumber(this.getSelectedCharacterIndex()),this._aCharactersList[this.getSelectedCharacterIndex()].name]);
               }
               else
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.warnBeforeDelete",this._aCharactersList[this.getSelectedCharacterIndex()].name),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onPopupDelete,this.onPopupClose],this.onPopupDelete,this.onPopupClose);
               }
               break;
            case this.btn_create:
               Connection.getInstance().characterCreationStart();
               break;
            case this.btn_changeServer:
               this.sysApi.sendAction(new ChangeServer());
               break;
            case this.btn_bigArrowLeft:
               this.rotateMountains(-1);
               break;
            case this.btn_bigArrowRight:
               this.rotateMountains(1);
               break;
            case this.btn_leftArrow:
               this.charaWheel.wheelChara(1);
               break;
            case this.btn_rightArrow:
               this.charaWheel.wheelChara(-1);
               break;
            case this.characCb:
            case this.grid_character:
               break;
            default:
               nbCharacters = this._aCharactersList.length;
               if(nbCharacters <= 5)
               {
                  i = 0;
                  while(i < nbCharacters)
                  {
                     if(target.name == this.charaWheel.getMountainCtr(i).name)
                     {
                        t = 2 * Math.PI / nbCharacters;
                        sens = i - this.getSelectedCharacterIndex();
                        if(Math.abs(sens) > nbCharacters / 2)
                        {
                           if(sens > 0)
                           {
                              sens = sens - nbCharacters;
                           }
                           else
                           {
                              sens = sens + nbCharacters;
                           }
                        }
                        this.rotateMountains(-sens);
                     }
                     i++;
                  }
               }
         }
      }
      
      public function onDoubleClick(target:Object) : void {
         var nbCharacters:* = 0;
         var i:* = 0;
         switch(target)
         {
            case this.btn_play:
               this.validateCharacterChoice(this.getSelectedCharacterIndex());
               break;
            case this.characCb:
               break;
            case this.btn_bigArrowLeft:
               this.rotateMountains(-1);
               break;
            case this.btn_bigArrowRight:
               this.rotateMountains(1);
               break;
            case this.btn_leftArrow:
               this.charaWheel.wheelChara(1);
               break;
            case this.btn_rightArrow:
               this.charaWheel.wheelChara(-1);
               break;
            default:
               nbCharacters = this._aCharactersList.length;
               if(nbCharacters <= 5)
               {
                  i = 0;
                  while(i < nbCharacters)
                  {
                     if((this.charaWheel) && (target.name == this.charaWheel.getMountainCtr(i).name))
                     {
                        this.soundApi.playSound(SoundTypeEnum.PLAY_BUTTON);
                        this.validateCharacterChoice(i);
                     }
                     i++;
                  }
               }
               else
               {
                  this.soundApi.playSound(SoundTypeEnum.PLAY_BUTTON);
                  this.validateCharacterChoice(this.getSelectedCharacterIndex());
               }
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               if(!this._askToDelete)
               {
                  this.validateCharacterChoice(this.getSelectedCharacterIndex());
               }
               return true;
            case "rightArrow":
               if(this._aCharactersList.length <= 5)
               {
                  this.rotateMountains(1);
               }
               return true;
            case "leftArrow":
               if(this._aCharactersList.length <= 5)
               {
                  this.rotateMountains(-1);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function onCharactersListUpdated(charactersList:Object) : void {
         var cha:* = undefined;
         var server:Object = null;
         var aEntities:Array = null;
         var perso1:Object = null;
         var i:* = 0;
         var e:* = 0;
         var j:* = 0;
         var charac:Object = null;
         var label:String = null;
         var charaObject:Object = null;
         if(this._askToDelete)
         {
            this.soundApi.playSound(SoundTypeEnum.DELETE_CHARACTER);
            this._askToDelete = false;
            this.btn_play.disabled = false;
            this._lockPopup = null;
         }
         this.charaWheel.charaCtr = this.charaSelCtr;
         this.charaWheel.frontCtr = this.frontZCtr;
         this.charaWheel.midCtr = this.midZCtr;
         var bonusXpCreation:int = 1;
         this._aCharactersList = new Array();
         for each(cha in charactersList)
         {
            this._aCharactersList.push(cha);
            if(cha.level > 1)
            {
               bonusXpCreation++;
            }
         }
         server = this.sysApi.getCurrentServer();
         if(server.gameTypeId == 0)
         {
            this.tx_bonusXpCreation.gotoAndStop = bonusXpCreation > 4?"4":bonusXpCreation.toString();
         }
         else
         {
            this.tx_bonusXpCreation.gotoAndStop = 1;
         }
         this._nbCharacters = this._aCharactersList.length;
         if(this._nbCharacters == 0)
         {
            this.btn_play.disabled = true;
            this.btn_cross.visible = false;
            this.btn_bigArrowLeft.visible = false;
            this.btn_bigArrowRight.visible = false;
            this.btn_leftArrow.visible = false;
            this.btn_rightArrow.visible = false;
            this.btn_resetCharacter.visible = false;
         }
         else
         {
            if(this._nbCharacters == 1)
            {
               this.btn_bigArrowLeft.disabled = true;
               this.btn_bigArrowRight.disabled = true;
            }
            else if((this._nbCharacters > 3) && (this._nbCharacters < 6))
            {
               perso1 = this._aCharactersList[1];
               i = 1;
               while(i < this._nbCharacters - 1)
               {
                  this._aCharactersList[i] = this._aCharactersList[i + 1];
                  i++;
               }
               this._aCharactersList[this._nbCharacters - 1] = perso1;
            }
            
            aEntities = new Array();
            if(this._nbCharacters < 6)
            {
               this.btn_bigArrowLeft.visible = true;
               this.btn_bigArrowRight.visible = true;
               this.btn_bigArrowLeft.disabled = false;
               this.btn_bigArrowRight.disabled = false;
               this.ctr_extendedList.visible = false;
               e = 0;
               while(e < this._nbCharacters)
               {
                  aEntities.push(
                     {
                        "id":this._aCharactersList[e].id,
                        "look":this._aCharactersList[e].entityLook,
                        "disabled":this._aCharactersList[e].unusable
                     });
                  e++;
               }
               this.charaWheel.entities = aEntities;
               this.charaWheel.dataProvider = this._aCharactersList;
               this.updateSelectedCharacter();
            }
            else
            {
               this.btn_bigArrowLeft.disabled = true;
               this.btn_bigArrowRight.disabled = true;
               this.btn_bigArrowLeft.visible = false;
               this.btn_bigArrowRight.visible = false;
               this.ctr_extendedList.visible = true;
               this._cbProvider = new Array();
               j = 0;
               while(j < this._nbCharacters)
               {
                  charac = this._aCharactersList[j];
                  if(charac != null)
                  {
                     label = charac.name + " (" + charac.breed.shortName + " " + charac.level + ")";
                     charaObject = 
                        {
                           "label":label,
                           "character":charac
                        };
                     this._cbProvider.push(charaObject);
                  }
                  j++;
               }
               this.lbl_List.text = this.uiApi.getText("ui.connection.listCharacterLabel",this._cbProvider.length);
               this.grid_character.dataProvider = this._cbProvider;
            }
         }
      }
      
      public function updateCharaWheel(index:int) : void {
         var aEntities:Array = new Array();
         aEntities.push(
            {
               "id":this._aCharactersList[index].id,
               "look":this._aCharactersList[index].entityLook
            });
         this.charaWheel.entities = aEntities;
         this.charaWheel.dataProvider = new Array(this._aCharactersList[index]);
         this.updateSelectedCharacter();
      }
      
      public function lockSelection() : void {
         this.btn_play.disabled = true;
         this._lockPopup = this.modCommon.openLockedPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.queue.wait"),null,true,true,[CharactersListUpdated,CharacterDeletionError],true,true);
      }
      
      public function onCharacterDeletionError(reason:String) : void {
         this._askToDelete = false;
         this.btn_play.disabled = false;
         this._lockPopup = null;
         this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.charSel.deletionError" + reason),[this.uiApi.getText("ui.common.ok")]);
      }
      
      public function onCharacterImpossibleSelection(pCharacterId:uint) : void {
         this.btn_play.disabled = false;
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.impossible_action"),this.uiApi.getText("ui.common.cantSelectThisCharacter"),[this.uiApi.getText("ui.common.ok")]);
      }
      
      public function onPackRestrictedSubArea(subAreaId:uint) : void {
         var subArea:SubArea = this.dataApi.getSubArea(subAreaId);
         var pack:Pack = this.dataApi.getPack(subArea.packId);
         if((this.sysApi.hasPart(pack.name)) && (this.sysApi.isDownloadFinished()))
         {
            this.onAllDownloadTerminated();
         }
         else if(!this.uiApi.getUi("unavailableCharacterPopup"))
         {
            this.uiApi.loadUi("unavailableCharacterPopup");
         }
         
      }
      
      public function onPopupClose() : void {
      }
      
      public function onPopupDelete() : void {
         this.lockSelection();
         this.sysApi.sendAction(new CharacterDeletion(this.getIdCharByNumber(this.getSelectedCharacterIndex()),"000000000000000000"));
      }
      
      public function onPopupReset() : void {
         this.sysApi.sendAction(new CharacterReplayRequest(this.getIdCharByNumber(this.getSelectedCharacterIndex())));
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         switch(target)
         {
            case this.btn_cross:
               tooltipText = this.uiApi.getText("ui.charsel.characterDelete");
               break;
            case this.tx_bonusXp:
            case this.tx_bonusXpCreation:
               tooltipText = this.uiApi.getText("ui.information.xpFamilyBonus");
               break;
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",0,8,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         switch(target)
         {
            case this.grid_character:
               this.updateCharaWheel(this.getSelectedCharacterIndex());
               if(selectMethod == 1)
               {
                  this.validateCharacterChoice(this.getSelectedCharacterIndex());
               }
               break;
         }
      }
      
      private function getSelectedCharacterIndex() : int {
         var size:* = 0;
         var obj:Object = null;
         var index:int = 0;
         if(this._aCharactersList.length > 0)
         {
            if(this._aCharactersList.length > 5)
            {
               size = this._aCharactersList.length;
               index = 0;
               while(index < size)
               {
                  obj = this._aCharactersList[index];
                  if(obj.id == this.grid_character.selectedItem.character.id)
                  {
                     break;
                  }
                  index++;
               }
            }
            else
            {
               index = this.charaWheel.selectedChara;
            }
         }
         return index;
      }
      
      public function onAllDownloadTerminated() : void {
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.split.rebootConfirm",[]),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmRestart,null],this.onConfirmRestart);
      }
      
      public function onConfirmRestart() : void {
         this.sysApi.reset();
      }
      
      public function onDownloadError(reason:String) : void {
         this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.split.downloadError",[]),[this.uiApi.getText("ui.common.ok")]);
      }
   }
}
