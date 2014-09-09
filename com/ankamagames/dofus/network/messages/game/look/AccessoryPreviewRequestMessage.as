package com.ankamagames.dofus.network.messages.game.look
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AccessoryPreviewRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AccessoryPreviewRequestMessage() {
         this.genericId = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6518;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var genericId:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6518;
      }
      
      public function initAccessoryPreviewRequestMessage(genericId:Vector.<uint> = null) : AccessoryPreviewRequestMessage {
         this.genericId = genericId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.genericId = new Vector.<uint>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AccessoryPreviewRequestMessage(output);
      }
      
      public function serializeAs_AccessoryPreviewRequestMessage(output:IDataOutput) : void {
         output.writeShort(this.genericId.length);
         var _i1:uint = 0;
         while(_i1 < this.genericId.length)
         {
            if(this.genericId[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.genericId[_i1] + ") on element 1 (starting at 1) of genericId.");
            }
            else
            {
               output.writeInt(this.genericId[_i1]);
               _i1++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AccessoryPreviewRequestMessage(input);
      }
      
      public function deserializeAs_AccessoryPreviewRequestMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _genericIdLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _genericIdLen)
         {
            _val1 = input.readInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of genericId.");
            }
            else
            {
               this.genericId.push(_val1);
               _i1++;
               continue;
            }
         }
      }
   }
}
