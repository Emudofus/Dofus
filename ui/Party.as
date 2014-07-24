package 
{
   import flash.display.Sprite;
   import ui.TeamSearch;
   import ui.PartyDisplay;
   import ui.items.PartyMember;
   import ui.JoinParty;
   import ui.PvpArena;
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.SocialApi;
   import d2api.PlayedCharacterApi;
   import d2hooks.*;
   import d2actions.*;
   
   public class Party extends Sprite
   {
      
      public function Party() {
         super();
      }
      
      private static var _self:Party;
      
      public static const PARTY_DISPLAY_UI:String = "partyDisplay";
      
      public static const PARTY_JOIN_UI:String = "partyJoin";
      
      public static var CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA:Boolean;
      
      public static function getInstance() : Party {
         return _self;
      }
      
      protected var teamSearch:TeamSearch = null;
      
      protected var partyDisplay:PartyDisplay = null;
      
      protected var partyMember:PartyMember = null;
      
      protected var joinParty:JoinParty = null;
      
      protected var pvpArena:PvpArena = null;
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var socialApi:SocialApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var modCommon:Object;
      
      private var _popupName:String;
      
      private var _otherName:String;
      
      private var _teamSearchTab:int;
      
      private var _teamSearchDonjon:int;
      
      public function main() : void {
         _self = this;
         this.sysApi.addHook(OpenTeamSearch,this.onOpenTeamSearch);
         this.sysApi.addHook(OpenArena,this.onOpenArena);
         this.sysApi.addHook(PartyInvitation,this.onPartyInvitation);
         this.sysApi.addHook(PartyCannotJoinError,this.onPartyCannotJoinError);
         this.sysApi.addHook(PartyRefuseInvitationNotification,this.onPartyRefuseInvitationNotification);
         this.sysApi.addHook(PartyJoin,this.onPartyJoin);
         this.sysApi.addHook(PartyCancelledInvitation,this.onPartyCancelledInvitation);
      }
      
      public function get teamSearchTab() : int {
         return this._teamSearchTab;
      }
      
      public function set teamSearchTab(value:int) : void {
         this._teamSearchTab = value;
      }
      
      public function get teamSearchDonjon() : int {
         return this._teamSearchDonjon;
      }
      
      public function set teamSearchDonjon(value:int) : void {
         this._teamSearchDonjon = value;
      }
      
      public function onPartyInvitation(partyId:uint, fromName:String, leaderId:uint, typeId:uint, members:Object, guests:Object, dungeonId:uint = 0, membersReady:Object = null, partyName:String = "") : void {
         if(this.socialApi.isIgnored(fromName))
         {
            return;
         }
         if(this.uiApi.getUi(PARTY_JOIN_UI))
         {
            this.uiApi.unloadUi(PARTY_JOIN_UI);
         }
         this.uiApi.loadUi(PARTY_JOIN_UI,PARTY_JOIN_UI,[partyId,fromName,leaderId,typeId,members,guests,dungeonId,membersReady,partyName]);
      }
      
      public function onPartyJoin(id:int, pMembers:Object, restrict:Boolean, isArenaParty:Boolean, name:String = "") : void {
         if(this.uiApi.getUi(PARTY_JOIN_UI))
         {
            this.uiApi.unloadUi(PARTY_JOIN_UI);
         }
         if(!this.uiApi.getUi(PARTY_DISPLAY_UI))
         {
            this.uiApi.loadUi(PARTY_DISPLAY_UI,PARTY_DISPLAY_UI,
               {
                  "partyMembers":pMembers,
                  "restricted":restrict,
                  "arena":isArenaParty,
                  "id":id,
                  "name":name
               });
         }
      }
      
      public function onOpenTeamSearch() : void {
         if(this.uiApi.getUi("teamSearch"))
         {
            this.uiApi.unloadUi("teamSearch");
         }
         else
         {
            this.uiApi.loadUi("teamSearch","teamSearch");
         }
      }
      
      public function onOpenArena() : void {
         if(this.uiApi.getUi("pvpArena"))
         {
            this.uiApi.unloadUi("pvpArena");
         }
         else
         {
            this.uiApi.loadUi("pvpArena","pvpArena");
         }
      }
      
      private function onPartyCannotJoinError(reason:String) : void {
         this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),reason,[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onPartyRefuseInvitationNotification() : void {
         if(this.uiApi.getUi(PARTY_JOIN_UI))
         {
            this.uiApi.unloadUi(PARTY_JOIN_UI);
         }
      }
      
      private function onAcceptInvitation() : void {
      }
      
      private function onRefuseInvitation() : void {
      }
      
      private function onCancelInvitation() : void {
      }
      
      private function onIgnoreInvitation() : void {
      }
      
      private function onPartyCancelledInvitation(partyId:uint = 0) : void {
         if(this.uiApi.getUi(PARTY_JOIN_UI))
         {
            this.uiApi.unloadUi(PARTY_JOIN_UI);
         }
      }
   }
}
