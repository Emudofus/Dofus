package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.FightApi;
   import d2api.TimeApi;
   import d2api.DataApi;
   import d2api.PlayedCharacterApi;
   import d2api.SoundApi;
   import d2components.ButtonContainer;
   import d2components.ComboBox;
   import d2components.Label;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2enums.ComponentHookList;
   import d2enums.ShortcutHookListEnum;
   import d2data.*;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.SelectMethodEnum;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   
   public class MainMenu extends Object
   {
      
      public function MainMenu() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var fightApi:FightApi;
      
      public var timeApi:TimeApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      private var _charsNames:Array;
      
      private var _characters:Array;
      
      private var _serversNames:Array;
      
      private var _servers:Array;
      
      private var _charPopupName:String;
      
      private var _serverPopupName:String;
      
      public var btnClose:ButtonContainer;
      
      public var btnOptions:ButtonContainer;
      
      public var btnChangeCharacter:ButtonContainer;
      
      public var btnChangeServer:ButtonContainer;
      
      public var btnDisconnect:ButtonContainer;
      
      public var btnQuitGame:ButtonContainer;
      
      public var btnCancel:ButtonContainer;
      
      public var cb_characters:ComboBox;
      
      public var cb_servers:ComboBox;
      
      public var btn_subscribe:ButtonContainer;
      
      public var lbl_abo:Label;
      
      public function main(args:Object) : void {
         var char:BasicCharacterWrapper = null;
         var serverId:* = 0;
         if(this.sysApi.isStreaming())
         {
            this.btnQuitGame.visible = false;
            this.btnChangeCharacter.y = this.btnChangeCharacter.y + 8;
            this.cb_characters.y = this.cb_characters.y + 8;
            this.cb_servers.y = this.cb_servers.y + 16;
            this.btnChangeServer.y = this.btnChangeServer.y + 16;
            this.btnDisconnect.y = this.btnDisconnect.y + 24;
         }
         this.soundApi.playSound(SoundTypeEnum.OPTIONS_OPEN);
         this.btnOptions.soundId = SoundEnum.SPEC_BUTTON;
         this.btnChangeCharacter.soundId = SoundEnum.SPEC_BUTTON;
         this.btnChangeServer.soundId = SoundEnum.SPEC_BUTTON;
         this.btnDisconnect.soundId = SoundEnum.SPEC_BUTTON;
         this.btnCancel.soundId = SoundEnum.CANCEL_BUTTON;
         this.sysApi.addHook(GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(GameFightJoin,this.onGameFightJoin);
         this.uiApi.addComponentHook(this.lbl_abo,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_abo,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cb_characters,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_servers,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onShortcut);
         this.btnChangeCharacter.disabled = (this.sysApi.isFightContext()) && (!this.fightApi.isSpectator());
         this.btnChangeServer.disabled = (this.sysApi.isFightContext()) && (!this.fightApi.isSpectator());
         this.cb_characters.disabled = (this.sysApi.isFightContext()) && (!this.fightApi.isSpectator());
         this.cb_servers.disabled = (this.sysApi.isFightContext()) && (!this.fightApi.isSpectator());
         if(this.sysApi.getPlayerManager().subscriptionEndDate == 0)
         {
            if(this.sysApi.getPlayerManager().hasRights)
            {
               this.lbl_abo.text = this.uiApi.getText("ui.common.admin");
            }
            else
            {
               this.lbl_abo.text = this.uiApi.getText("ui.common.non_subscriber");
            }
         }
         else if(this.sysApi.getPlayerManager().subscriptionEndDate < 2.0512224E12)
         {
            this.lbl_abo.text = this.uiApi.getText("ui.connection.subscriberUntil",this.timeApi.getDate(this.sysApi.getPlayerManager().subscriptionEndDate,true) + " " + this.timeApi.getClock(this.sysApi.getPlayerManager().subscriptionEndDate,true,true));
         }
         else
         {
            this.lbl_abo.text = this.uiApi.getText("ui.common.infiniteSubscription");
         }
         
         this.cb_characters.useKeyboard = false;
         this.cb_servers.useKeyboard = false;
         if((this.sysApi.getPlayerManager().charactersList) && (this.sysApi.getPlayerManager().charactersList.length > 1))
         {
            this._charsNames = new Array();
            this._characters = new Array();
            for each(char in this.sysApi.getPlayerManager().charactersList)
            {
               if((!(char.id == this.playerApi.id())) || (this.sysApi.getPlayerManager().hasRights))
               {
                  this._charsNames.push(char.name + " (" + char.breed.shortName + " " + char.level + ")");
                  this._characters.push(char);
               }
            }
            this.cb_characters.dataProvider = this._charsNames;
         }
         else
         {
            this.cb_characters.disabled = true;
         }
         if((this.sysApi.getPlayerManager().serversList) && (this.sysApi.getPlayerManager().serversList.length > 1))
         {
            this._serversNames = new Array();
            this._servers = new Array();
            for each(serverId in this.sysApi.getPlayerManager().serversList)
            {
               if(serverId != this.sysApi.getCurrentServer().id)
               {
                  this._serversNames.push(this.dataApi.getServer(serverId).name);
                  this._servers.push(serverId);
               }
            }
            this.cb_servers.dataProvider = this._serversNames;
         }
         else
         {
            this.cb_servers.disabled = true;
         }
      }
      
      public function unload() : void {
         this.soundApi.playSound(SoundTypeEnum.OPTIONS_CLOSE);
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btnOptions:
               this.modCommon.openOptionMenu(false,"performance");
               break;
            case this.btnChangeCharacter:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.common.confirmChangeCharacter"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmChangeCharacter,this.onCancel],this.onConfirmChangeCharacter,this.onCancel);
               break;
            case this.btnChangeServer:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.connection.confirmChangeServer"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmChangeServer,this.onCancel],this.onConfirmChangeServer,this.onCancel);
               break;
            case this.btnDisconnect:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.common.confirmDisconnect"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmDisconnect,this.onCancel],this.onConfirmDisconnect,this.onCancel);
               break;
            case this.btnQuitGame:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.common.confirmQuitGame"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmQuitGame,this.onCancel],this.onConfirmQuitGame,this.onCancel);
               break;
            case this.btnCancel:
            case this.btnClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_subscribe:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.subscribe"));
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if((selectMethod == SelectMethodEnum.CLICK) || (selectMethod == SelectMethodEnum.MANUAL) || (selectMethod == SelectMethodEnum.DOUBLE_CLICK))
         {
            switch(target)
            {
               case this.cb_characters:
                  if(!this._charPopupName)
                  {
                     this._charPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.connection.confirmDirectCharacter",this._charsNames[this.cb_characters.selectedIndex]),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmCharacterDirectSelection,this.onCancel],this.onConfirmCharacterDirectSelection,this.onCancel);
                  }
                  break;
               case this.cb_servers:
                  if(!this._serverPopupName)
                  {
                     this._serverPopupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.confirm"),this.uiApi.getText("ui.connection.confirmDirectServer",this._serversNames[this.cb_servers.selectedIndex]),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmServerDirectSelection,this.onCancel],this.onConfirmServerDirectSelection,this.onCancel);
                  }
                  break;
            }
         }
      }
      
      public function onRollOver(target:Object) : void {
         switch(target)
         {
            case this.lbl_abo:
               if(this.sysApi.getPlayerManager().subscriptionEndDate > 0)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.header.subscriptionEndDate")),target,false,"standard",2,8,0,null,null,null,"TextInfo");
               }
               break;
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function onConfirmCharacterDirectSelection() : void {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new DirectSelectionCharacter(this.sysApi.getCurrentServer().id,this._characters[this.cb_characters.selectedIndex].id));
      }
      
      private function onConfirmServerDirectSelection() : void {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new ChangeCharacter(this._servers[this.cb_servers.selectedIndex]));
      }
      
      private function onConfirmChangeCharacter() : void {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new ChangeCharacter(this.sysApi.getCurrentServer().id));
      }
      
      private function onConfirmChangeServer() : void {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new ChangeServer());
      }
      
      private function onConfirmDisconnect() : void {
         this.uiApi.unloadUi(UIEnum.TUTORIAL_UI);
         this.sysApi.sendAction(new ResetGame());
      }
      
      private function onConfirmQuitGame() : void {
         this.sysApi.sendAction(new QuitGame());
      }
      
      private function onCancel() : void {
         this._charPopupName = null;
         this._serverPopupName = null;
      }
      
      public function onGameFightJoin(... rest) : void {
         this.btnChangeCharacter.disabled = true;
         this.btnChangeServer.disabled = true;
         this.cb_characters.disabled = true;
         this.cb_servers.disabled = true;
      }
      
      public function onGameFightEnd(... rest) : void {
         this.btnChangeCharacter.disabled = false;
         this.btnChangeServer.disabled = false;
         this.cb_characters.disabled = false;
         this.cb_servers.disabled = false;
      }
      
      public function onShortcut(s:String) : Boolean {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         if(s == ShortcutHookListEnum.VALID_UI)
         {
         }
         return false;
      }
   }
}
