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
      
      public function initFightOptionsInformations(isSecret:Boolean = false, isRestrictedToPartyOnly:Boolean = false, isClosed:Boolean = false, isAskingForHelp:Boolean = false) : FightOptionsInformations {
         this.isSecret = isSecret;
         this.isRestrictedToPartyOnly = isRestrictedToPartyOnly;
         this.isClosed = isClosed;
         this.isAskingForHelp = isAskingForHelp;
         return this;
      }
      
      public function reset() : void {
         this.isSecret = false;
         this.isRestrictedToPartyOnly = false;
         this.isClosed = false;
         this.isAskingForHelp = false;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightOptionsInformations(output);
      }
      
      public function serializeAs_FightOptionsInformations(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.isSecret);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isRestrictedToPartyOnly);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.isClosed);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.isAskingForHelp);
         output.writeByte(_box0);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightOptionsInformations(input);
      }
      
      public function deserializeAs_FightOptionsInformations(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.isSecret = BooleanByteWrapper.getFlag(_box0,0);
         this.isRestrictedToPartyOnly = BooleanByteWrapper.getFlag(_box0,1);
         this.isClosed = BooleanByteWrapper.getFlag(_box0,2);
         this.isAskingForHelp = BooleanByteWrapper.getFlag(_box0,3);
      }
   }
}
