package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredInformations;
   import com.ankamagames.dofus.network.types.game.friend.IgnoredOnlineInformations;
   
   public class EnemyWrapper extends Object implements IDataCenter
   {
      
      public function EnemyWrapper(o:IgnoredInformations) {
         super();
         this._item = o;
         this.name = o.accountName;
         this.accountId = o.accountId;
         if(o is IgnoredOnlineInformations)
         {
            this.playerName = IgnoredOnlineInformations(o).playerName;
            this.playerId = IgnoredOnlineInformations(o).playerId;
            this.breed = IgnoredOnlineInformations(o).breed;
            this.sex = IgnoredOnlineInformations(o).sex?1:0;
            this.online = true;
         }
      }
      
      private var _item:IgnoredInformations;
      
      public var name:String = "";
      
      public var accountId:int;
      
      public var state:int = 1;
      
      public var lastConnection:int = -1;
      
      public var online:Boolean = false;
      
      public var type:String = "Enemy";
      
      public var playerId:int;
      
      public var playerName:String = "";
      
      public var breed:uint = 0;
      
      public var sex:uint = 2;
      
      public var level:int = 0;
      
      public var alignmentSide:int = -1;
      
      public var guildName:String = "";
      
      public var achievementPoints:int = -1;
   }
}
