package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;
   
   public class FightOptionsInformations extends Object implements INetworkType
   {
      
      public function FightOptionsInformations() {
         super();
      }
      
      public static const protocolId:uint = 20;
      
      public var isSecret:Boolean = false;
      
      public var isRestrictedToPartyOnly:Boolean = false;
      
      public var isClosed:Boolean = false;
      
      public var isAskingForHelp:Boolean = false;
      
      public function getTypeId() : uint {
         return 20;
      }
      
      public function initFightOptionsInformations(param1:Boolean=false, param2:Boolean=false, param3:Boolean=false, param4:Boolean=false) : FightOptionsInformations {
         this.isSecret = param1;
         this.isRestrictedToPartyOnly = param2;
         this.isClosed = param3;
         this.isAskingForHelp = param4;
         return this;
      }
      
      public function reset() : void {
         this.isSecret = false;
         this.isRestrictedToPartyOnly = false;
         this.isClosed = false;
         this.isAskingForHelp = false;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightOptionsInformations(param1);
      }
      
      public function serializeAs_FightOptionsInformations(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.isSecret);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.isRestrictedToPartyOnly);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,2,this.isClosed);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,3,this.isAskingForHelp);
         param1.writeByte(_loc2_);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightOptionsInformations(param1);
      }
      
      public function deserializeAs_FightOptionsInformations(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.isSecret = BooleanByteWrapper.getFlag(_loc2_,0);
         this.isRestrictedToPartyOnly = BooleanByteWrapper.getFlag(_loc2_,1);
         this.isClosed = BooleanByteWrapper.getFlag(_loc2_,2);
         this.isAskingForHelp = BooleanByteWrapper.getFlag(_loc2_,3);
      }
   }
}
