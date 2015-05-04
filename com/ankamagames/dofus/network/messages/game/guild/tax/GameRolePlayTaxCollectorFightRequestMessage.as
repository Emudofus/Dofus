package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameRolePlayTaxCollectorFightRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayTaxCollectorFightRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5954;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var taxCollectorId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5954;
      }
      
      public function initGameRolePlayTaxCollectorFightRequestMessage(param1:int = 0) : GameRolePlayTaxCollectorFightRequestMessage
      {
         this.taxCollectorId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayTaxCollectorFightRequestMessage(param1);
      }
      
      public function serializeAs_GameRolePlayTaxCollectorFightRequestMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.taxCollectorId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayTaxCollectorFightRequestMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayTaxCollectorFightRequestMessage(param1:ICustomDataInput) : void
      {
         this.taxCollectorId = param1.readInt();
      }
   }
}
