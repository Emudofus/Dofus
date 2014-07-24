package makers
{
   import d2actions.*;
   import d2hooks.*;
   import d2enums.CharacterInventoryPositionEnum;
   import d2data.PartyMemberWrapper;
   import d2network.GameFightCompanionInformations;
   import d2data.PartyCompanionWrapper;
   
   public class CompanionMenuMaker extends Object
   {
      
      public function CompanionMenuMaker() {
         super();
      }
      
      public static var disabled:Boolean = false;
      
      private function onDismiss() : void {
         var companionUID:* = 0;
         var item:Object = null;
         var equipment:Object = Api.storage.getViewContent("equipment");
         for each(item in equipment)
         {
            if((item) && (item.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_COMPANION))
            {
               companionUID = item.objectUID;
               break;
            }
         }
         if(companionUID != 0)
         {
            Api.system.sendAction(new ObjectSetPosition(companionUID,63,1));
         }
      }
      
      private function onSwitchPlaces(cellId:int) : void {
         Api.system.sendAction(new GameFightPlacementPositionRequest(cellId));
      }
      
      protected function onKick(targetId:uint) : void {
         Api.system.sendAction(new GameContextKick(targetId));
      }
      
      protected function kickPlayer(partyId:int, playerId:uint) : void {
         Api.system.sendAction(new PartyKickRequest(partyId,playerId));
      }
      
      protected function cancelPartyInvitation(partyId:int, guestId:uint) : void {
         Api.system.sendAction(new PartyCancelInvitation(partyId,guestId));
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var cData:Object = null;
         var playerId:* = 0;
         var playerName:String = null;
         var companionName:String = null;
         var partyId:* = 0;
         var playerIsGuest:* = false;
         var partyMember:PartyMemberWrapper = null;
         if(data is GameFightCompanionInformations)
         {
            cData = data as GameFightCompanionInformations;
            if((Api.player.isInFight()) && (!Api.player.isInPreFight()))
            {
               return [];
            }
            playerId = cData.masterId;
            companionName = Api.data.getCompanion(cData.companionGenericId).name;
            if(playerId != Api.player.id())
            {
               playerName = Api.fight.getFighterName(playerId);
               companionName = Api.ui.getText("ui.common.belonging",companionName,playerName);
            }
            else
            {
               playerName = Api.player.getPlayedCharacterInfo().name;
            }
         }
         else
         {
            cData = data as PartyCompanionWrapper;
            playerId = cData.id;
            playerName = cData.masterName;
            companionName = cData.name;
         }
         var menu:Array = new Array();
         menu.push(ContextMenu.static_createContextMenuTitleObject(companionName));
         if(playerId == Api.player.id())
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.companion.dismiss"),this.onDismiss,[]),disabled);
            if((Api.player.isInPreFight()) && (cData.hasOwnProperty("disposition")) && (cData.disposition))
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.companion.switchPlaces"),this.onSwitchPlaces,[cData.disposition.cellId]),disabled);
            }
         }
         else
         {
            if((Api.player.isInPreFight()) && (Api.fight.isFightLeader()))
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.fight.kickSomeone",playerName),this.onKick,[playerId]),disabled);
            }
            if(Api.player.isInParty())
            {
               partyId = Api.party.getPartyId();
               if((partyId > 0) && (Api.party.getPartyLeaderId(partyId) == Api.player.id()))
               {
                  playerIsGuest = false;
                  for each(partyMember in Api.party.getPartyMembers(0))
                  {
                     if(partyMember.id == playerId)
                     {
                        playerIsGuest = !partyMember.isMember;
                        break;
                     }
                  }
                  if(playerIsGuest)
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.cancelInvitationForSomeone",playerName),this.cancelPartyInvitation,[partyId,playerId]));
                  }
                  else
                  {
                     menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.party.kickSomeone",playerName),this.kickPlayer,[partyId,playerId]));
                  }
               }
            }
         }
         if(menu.length == 1)
         {
            menu = null;
         }
         return menu;
      }
   }
}
