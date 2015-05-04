package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceFactsErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceFactsErrorMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6423;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var allianceId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6423;
      }
      
      public function initAllianceFactsErrorMessage(param1:uint = 0) : AllianceFactsErrorMessage
      {
         this.allianceId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceId = 0;
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
         this.serializeAs_AllianceFactsErrorMessage(param1);
      }
      
      public function serializeAs_AllianceFactsErrorMessage(param1:ICustomDataOutput) : void
      {
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element allianceId.");
         }
         else
         {
            param1.writeVarInt(this.allianceId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFactsErrorMessage(param1);
      }
      
      public function deserializeAs_AllianceFactsErrorMessage(param1:ICustomDataInput) : void
      {
         this.allianceId = param1.readVarUhInt();
         if(this.allianceId < 0)
         {
            throw new Error("Forbidden value (" + this.allianceId + ") on element of AllianceFactsErrorMessage.allianceId.");
         }
         else
         {
            return;
         }
      }
   }
}
