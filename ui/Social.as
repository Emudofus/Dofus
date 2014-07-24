package 
{
   import flash.display.Sprite;
   import ui.SocialBase;
   import ui.Friends;
   import ui.Spouse;
   import ui.Guild;
   import ui.Alliance;
   import ui.Directory;
   import ui.GuildCard;
   import ui.AllianceCard;
   import ui.items.PonyXmlItem;
   import ui.items.AllianceFightXmlItem;
   import ui.GuildHouses;
   import ui.GuildMembers;
   import ui.GuildMemberRights;
   import ui.GuildPaddock;
   import ui.GuildPersonalization;
   import ui.GuildTaxCollector;
   import ui.GuildCreator;
   import ui.AllianceMembers;
   import ui.AllianceAreas;
   import ui.AllianceFights;
   import ui.AllianceCreator;
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.PlayedCharacterApi;
   import d2hooks.*;
   import d2actions.*;
   
   public class Social extends Sprite
   {
      
      public function Social() {
         super();
      }
      
      public var modCommon:Object;
      
      protected var socialBase:SocialBase;
      
      protected var friends:Friends;
      
      protected var spouse:Spouse;
      
      protected var guild:Guild;
      
      protected var alliance:Alliance;
      
      protected var directory:Directory;
      
      protected var guildCard:GuildCard;
      
      protected var allianceCard:AllianceCard;
      
      protected var ponyXmlItem:PonyXmlItem;
      
      protected var allianceFightXmlItem:AllianceFightXmlItem;
      
      protected var guildHouses:GuildHouses;
      
      protected var guildMembers:GuildMembers;
      
      protected var guildMemberRights:GuildMemberRights;
      
      protected var guildPaddock:GuildPaddock;
      
      protected var guildPersonalization:GuildPersonalization;
      
      protected var guildTaxCollector:GuildTaxCollector;
      
      protected var guildCreator:GuildCreator;
      
      protected var allianceMembers:AllianceMembers;
      
      protected var allianceAreas:AllianceAreas;
      
      protected var allianceFights:AllianceFights;
      
      protected var allianceCreator:AllianceCreator;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var socialApi:SocialApi;
      
      public var playerApi:PlayedCharacterApi;
      
      private var _firstTime:Boolean = true;
      
      private var _ava:Boolean;
      
      private var _targetId:int;
      
      private var _cellId:int;
      
      private var _popupName:String = null;
      
      private var _popupAllianceName:String = null;
      
      public function main() : void {
         Api.system = this.sysApi;
         Api.social = this.socialApi;
         Api.ui = this.uiApi;
         Api.player = this.playerApi;
         this.sysApi.addHook(OpenSocial,this.onOpenSocial);
         this.sysApi.addHook(ClientUIOpened,this.onClientUIOpened);
         this.sysApi.addHook(ContextChanged,this.onContextChanged);
         this.sysApi.addHook(GuildCreationStarted,this.onCreateGuild);
         this.sysApi.addHook(GuildInvited,this.onGuildInvited);
         this.sysApi.addHook(GuildInvitationStateRecruter,this.onGuildInvitationStateRecruter);
         this.sysApi.addHook(GuildInvitationStateRecruted,this.onGuildInvitationStateRecruted);
         this.sysApi.addHook(AllianceCreationStarted,this.onCreateAlliance);
         this.sysApi.addHook(AllianceInvited,this.onAllianceInvited);
         this.sysApi.addHook(AllianceInvitationStateRecruter,this.onAllianceInvitationStateRecruter);
         this.sysApi.addHook(AllianceInvitationStateRecruted,this.onAllianceInvitationStateRecruted);
         this.sysApi.addHook(AttackPlayer,this.onAttackPlayer);
         this.sysApi.addHook(DishonourChanged,this.onDishonourChanged);
         this.sysApi.addHook(OpenOneAlliance,this.onOpenOneAlliance);
         this.sysApi.addHook(OpenOneGuild,this.onOpenOneGuild);
      }
      
      private function onCreateGuild(modifyName:Boolean, modifyEmblem:Boolean) : void {
         this.uiApi.loadUi("guildCreator","guildCreator",[modifyName,modifyEmblem]);
      }
      
      private function onCreateAlliance(modifyName:Boolean, modifyEmblem:Boolean) : void {
         this.uiApi.loadUi("allianceCreator","allianceCreator",[modifyName,modifyEmblem]);
      }
      
      private function onOpenOneGuild(guild:Object) : void {
         this.uiApi.unloadUi("allianceCard");
         if(!this.uiApi.getUi("guildCard"))
         {
            this.uiApi.loadUi("guildCard","guildCard",{"guild":guild});
         }
      }
      
      private function onOpenOneAlliance(alliance:Object) : void {
         this.uiApi.unloadUi("guildCard");
         if(!this.uiApi.getUi("allianceCard"))
         {
            this.uiApi.loadUi("allianceCard","allianceCard",{"alliance":alliance});
         }
      }
      
      private function onOpenSocial(tab:int = -1, subTab:int = -1, params:Object = null) : void {
         var args:Object = null;
         if((tab == 2) && (!this.playerApi.characteristics()))
         {
            return;
         }
         if(!this.uiApi.getUi("socialBase"))
         {
            if((tab == 3) && (this.socialApi.getSpouse() == null))
            {
               return;
            }
            args = new Object();
            if(tab != -1)
            {
               args.tab = tab;
            }
            if(subTab != -1)
            {
               args.subTab = subTab;
            }
            if((!(params == null)) && (params.length > 0))
            {
               args.params = params;
            }
            this.uiApi.loadUi("socialBase","socialBase",args);
         }
         else if(this.uiApi.getUi("socialBase").uiClass.getTab() != tab)
         {
            if(subTab == -1)
            {
               this.uiApi.getUi("socialBase").uiClass.openTab(tab);
            }
            else if(params == null)
            {
               this.uiApi.getUi("socialBase").uiClass.openTab(tab,subTab);
            }
            else
            {
               this.uiApi.getUi("socialBase").uiClass.openTab(tab,subTab,params);
            }
            
         }
         else
         {
            this.uiApi.unloadUi("socialBase");
         }
         
      }
      
      private function onContextChanged(context:uint) : void {
         if(context == 2)
         {
            this.uiApi.unloadUi("socialBase");
         }
      }
      
      private function onClientUIOpened(type:uint, uid:uint) : void {
         if(this.socialApi.hasGuild())
         {
            if(!this.uiApi.getUi("socialBase"))
            {
               switch(type)
               {
                  case 0:
                     this.sysApi.log(16,"Error : wrong UI type to open.");
                     break;
                  case 1:
                     this.uiApi.loadUi("socialBase","socialBase",
                        {
                           "tab":1,
                           "subTab":4
                        });
                     break;
                  case 2:
                     this.uiApi.loadUi("socialBase","socialBase",
                        {
                           "tab":1,
                           "subTab":3
                        });
                     break;
                  case 4:
                     this.uiApi.loadUi("socialBase","socialBase",
                        {
                           "tab":1,
                           "subTab":2
                        });
                     break;
               }
            }
            else if(this.uiApi.getUi("socialBase").uiClass.getTab() != 1)
            {
               switch(type)
               {
                  case 1:
                     this.uiApi.getUi("socialBase").uiClass.openTab(1,4);
                     break;
                  case 2:
                     this.uiApi.getUi("socialBase").uiClass.openTab(1,3);
                     break;
                  case 4:
                     this.uiApi.getUi("socialBase").uiClass.openTab(1,2);
                     break;
               }
            }
            else
            {
               this.sysApi.log(16,"Error : Social UI is already open.");
            }
            
         }
      }
      
      private function onDishonourChanged(dishonour:int) : void {
         var maxDishonour:int = dishonour;
         if(maxDishonour > 9)
         {
            maxDishonour = 9;
         }
         var text:String = this.uiApi.processText(this.uiApi.getText("ui.social.disgraceSanction",dishonour),"n",dishonour < 2);
         text = text + ("\n\n" + this.uiApi.getText("ui.disgrace.sanction.1"));
         this.modCommon.openPopup(this.uiApi.getText("ui.common.informations"),text,[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onAttackPlayer(targetId:int, ava:Boolean, targetName:String, type:int, cellId:int) : void {
         var text:String = null;
         this._targetId = targetId;
         this._cellId = cellId;
         this._ava = ava;
         if((ava) || (type == 0))
         {
            text = this.uiApi.getText("ui.pvp.doUAttack",targetName);
         }
         else if(type == 2)
         {
            text = this.uiApi.getText("ui.pvp.doUAttackNeutral");
         }
         else if(type == -1)
         {
            text = this.uiApi.getText("ui.pvp.doUAttackNoGain",targetName);
         }
         else if(type == 1)
         {
            text = this.uiApi.getText("ui.pvp.doUAttackBonusGain",targetName);
         }
         
         
         
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),text,[this.uiApi.getText("ui.common.attack"),this.uiApi.getText("ui.common.cancel")],[this.onConfirmAttack,null],this.onConfirmAttack);
      }
      
      private function onConfirmAttack() : void {
         this.sysApi.sendAction(new PlayerFightRequest(this._targetId,this._ava,false,true));
      }
      
      private function onGuildInvited(guildName:String, recruterId:uint, recruterName:String) : void {
         this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.invitation"),this.uiApi.getText("ui.social.aInvitYouInGuild",recruterName,guildName),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmJoinGuild,this.onCancelJoinGuild],this.onConfirmJoinGuild,this.onCancelJoinGuild);
      }
      
      private function onConfirmJoinGuild() : void {
         this.sysApi.sendAction(new GuildInvitationAnswer(true));
      }
      
      private function onCancelJoinGuild() : void {
         this.sysApi.sendAction(new GuildInvitationAnswer(false));
      }
      
      private function onGuildInvitationStateRecruter(state:uint, recrutedName:String) : void {
         switch(state)
         {
            case 1:
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.common.invitation"),this.uiApi.getText("ui.craft.waitForCraftClient",recrutedName),[this.uiApi.getText("ui.common.cancel")],[this.onCancelJoinGuild],null,this.onCancelJoinGuild);
               break;
            case 2:
            case 3:
               if((this._popupName) && (this.uiApi.getUi(this._popupName)))
               {
                  this.uiApi.unloadUi(this._popupName);
                  this._popupName = null;
               }
               break;
         }
      }
      
      private function onGuildInvitationStateRecruted(state:uint) : void {
         switch(state)
         {
            case 1:
               break;
            case 2:
            case 3:
               if((this._popupName) && (this.uiApi.getUi(this._popupName)))
               {
                  this.uiApi.unloadUi(this._popupName);
                  this._popupName = null;
               }
               break;
         }
      }
      
      private function onAllianceInvited(allianceName:String, recruterId:uint, recruterName:String) : void {
         this._popupAllianceName = this.modCommon.openPopup(this.uiApi.getText("ui.common.invitation"),this.uiApi.getText("ui.alliance.youAreInvited",recruterName,allianceName),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmJoinAlliance,this.onCancelJoinAlliance],this.onConfirmJoinAlliance,this.onCancelJoinAlliance);
      }
      
      private function onConfirmJoinAlliance() : void {
         this.sysApi.sendAction(new AllianceInvitationAnswer(true));
      }
      
      private function onCancelJoinAlliance() : void {
         this.sysApi.sendAction(new AllianceInvitationAnswer(false));
      }
      
      private function onAllianceInvitationStateRecruter(state:uint, recrutedName:String) : void {
         switch(state)
         {
            case 1:
               this._popupAllianceName = this.modCommon.openPopup(this.uiApi.getText("ui.common.invitation"),this.uiApi.getText("ui.craft.waitForCraftClient",recrutedName),[this.uiApi.getText("ui.common.cancel")],[this.onCancelJoinAlliance],null,this.onCancelJoinAlliance);
               break;
            case 2:
            case 3:
               if((this._popupAllianceName) && (this.uiApi.getUi(this._popupAllianceName)))
               {
                  this.uiApi.unloadUi(this._popupAllianceName);
                  this._popupAllianceName = null;
               }
               break;
         }
      }
      
      private function onAllianceInvitationStateRecruted(state:uint) : void {
         switch(state)
         {
            case 1:
               break;
            case 2:
            case 3:
               if((this._popupAllianceName) && (this.uiApi.getUi(this._popupAllianceName)))
               {
                  this.uiApi.unloadUi(this._popupAllianceName);
                  this._popupAllianceName = null;
               }
               break;
         }
      }
   }
}
