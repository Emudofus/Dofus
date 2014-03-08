package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class IgnoredWrapper extends Object implements IDataCenter
   {
      
      public function IgnoredWrapper(name:String, accountId:uint) {
         super();
         this.name = name;
         this.accountId = accountId;
      }
      
      public var name:String = "";
      
      public var accountId:uint;
      
      public var state:int = 1;
      
      public var lastConnection:uint = 0;
      
      public var online:Boolean = true;
      
      public var type:String = "Ignored";
      
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
