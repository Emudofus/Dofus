package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendOnlineInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   
   public class FriendWrapper extends Object implements IDataCenter
   {
      
      public function FriendWrapper(param1:FriendInformations) {
         super();
         this._item = param1;
         this.name = param1.accountName;
         this.accountId = param1.accountId;
         this.state = param1.playerState;
         this.lastConnection = param1.lastConnection;
         this.achievementPoints = param1.achievementPoints;
         if(param1 is FriendOnlineInformations)
         {
            this.playerName = FriendOnlineInformations(param1).playerName;
            this.playerId = FriendOnlineInformations(param1).playerId;
            this.level = FriendOnlineInformations(param1).level;
            this.alignmentSide = FriendOnlineInformations(param1).alignmentSide;
            this.breed = FriendOnlineInformations(param1).breed;
            this.sex = FriendOnlineInformations(param1).sex?1:0;
            if(FriendOnlineInformations(param1).guildInfo.guildName == "#NONAME#")
            {
               this.guildName = I18n.getUiText("ui.guild.noName");
            }
            else
            {
               this.guildName = FriendOnlineInformations(param1).guildInfo.guildName;
            }
            this.realGuildName = FriendOnlineInformations(param1).guildInfo.guildName;
            this.moodSmileyId = FriendOnlineInformations(param1).moodSmileyId;
            this.statusId = FriendOnlineInformations(param1).status.statusId;
            if(FriendOnlineInformations(param1).status is PlayerStatusExtended)
            {
               this.awayMessage = PlayerStatusExtended(FriendOnlineInformations(param1).status).message;
            }
            this.online = true;
         }
      }
      
      private var _item:FriendInformations;
      
      public var name:String;
      
      public var accountId:int;
      
      public var state:int;
      
      public var lastConnection:uint;
      
      public var online:Boolean = false;
      
      public var type:String = "Friend";
      
      public var playerId:int;
      
      public var playerName:String = "";
      
      public var level:int = 0;
      
      public var moodSmileyId:int = -1;
      
      public var alignmentSide:int = 0;
      
      public var breed:uint = 0;
      
      public var sex:uint = 2;
      
      public var realGuildName:String = "";
      
      public var guildName:String = "";
      
      public var achievementPoints:int = 0;
      
      public var statusId:uint = 0;
      
      public var awayMessage:String = "";
   }
}
