package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class UpdateSelfAgressableStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function UpdateSelfAgressableStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6456;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var status:uint = 0;
      
      public var probationTime:uint = 0;
      
      override public function getMessageId() : uint {
         return 6456;
      }
      
      public function initUpdateSelfAgressableStatusMessage(param1:uint=0, param2:uint=0) : UpdateSelfAgressableStatusMessage {
         this.status = param1;
         this.probationTime = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.status = 0;
         this.probationTime = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_UpdateSelfAgressableStatusMessage(param1);
      }
      
      public function serializeAs_UpdateSelfAgressableStatusMessage(param1:IDataOutput) : void {
         param1.writeByte(this.status);
         if(this.probationTime < 0)
         {
            throw new Error("Forbidden value (" + this.probationTime + ") on element probationTime.");
         }
         else
         {
            param1.writeInt(this.probationTime);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_UpdateSelfAgressableStatusMessage(param1);
      }
      
      public function deserializeAs_UpdateSelfAgressableStatusMessage(param1:IDataInput) : void {
         this.status = param1.readByte();
         if(this.status < 0)
         {
            throw new Error("Forbidden value (" + this.status + ") on element of UpdateSelfAgressableStatusMessage.status.");
         }
         else
         {
            this.probationTime = param1.readInt();
            if(this.probationTime < 0)
            {
               throw new Error("Forbidden value (" + this.probationTime + ") on element of UpdateSelfAgressableStatusMessage.probationTime.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
