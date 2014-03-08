package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.friend.FriendInformations;
   import com.ankamagames.dofus.network.types.game.friend.FriendOnlineInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.types.game.character.status.PlayerStatusExtended;
   
   public class FriendWrapper extends Object implements IDataCenter
   {
      
      public function FriendWrapper(o:FriendInformations) {
         super();
         this._item = o;
         this.name = o.accountName;
         this.accountId = o.accountId;
         this.state = o.playerState;
         this.lastConnection = o.lastConnection;
         this.achievementPoints = o.achievementPoints;
         if(o is FriendOnlineInformations)
         {
            this.playerName = FriendOnlineInformations(o).playerName;
            this.playerId = FriendOnlineInformations(o).playerId;
            this.level = FriendOnlineInformations(o).level;
            this.alignmentSide = FriendOnlineInformations(o).alignmentSide;
            this.breed = FriendOnlineInformations(o).breed;
            this.sex = FriendOnlineInformations(o).sex?1:0;
            if(FriendOnlineInformations(o).guildInfo.guildName == "#NONAME#")
            {
               this.guildName = I18n.getUiText("ui.guild.noName");
            }
            else
            {
               this.guildName = FriendOnlineInformations(o).guildInfo.guildName;
            }
            this.realGuildName = FriendOnlineInformations(o).guildInfo.guildName;
            this.moodSmileyId = FriendOnlineInformations(o).moodSmileyId;
            this.statusId = FriendOnlineInformations(o).status.statusId;
            if(FriendOnlineInformations(o).status is PlayerStatusExtended)
            {
               this.awayMessage = PlayerStatusExtended(FriendOnlineInformations(o).status).message;
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
