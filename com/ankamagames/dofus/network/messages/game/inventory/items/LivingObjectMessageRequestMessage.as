package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LivingObjectMessageRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LivingObjectMessageRequestMessage() {
         this.parameters = new Vector.<String>();
         super();
      }
      
      public static const protocolId:uint = 6066;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var msgId:uint = 0;
      
      public var parameters:Vector.<String>;
      
      public var livingObject:uint = 0;
      
      override public function getMessageId() : uint {
         return 6066;
      }
      
      public function initLivingObjectMessageRequestMessage(msgId:uint = 0, parameters:Vector.<String> = null, livingObject:uint = 0) : LivingObjectMessageRequestMessage {
         this.msgId = msgId;
         this.parameters = parameters;
         this.livingObject = livingObject;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.msgId = 0;
         this.parameters = new Vector.<String>();
         this.livingObject = 0;
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
         this.serializeAs_LivingObjectMessageRequestMessage(output);
      }
      
      public function serializeAs_LivingObjectMessageRequestMessage(output:IDataOutput) : void {
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
         }
         else
         {
            output.writeShort(this.msgId);
            output.writeShort(this.parameters.length);
            _i2 = 0;
            while(_i2 < this.parameters.length)
            {
               output.writeUTF(this.parameters[_i2]);
               _i2++;
            }
            if((this.livingObject < 0) || (this.livingObject > 4.294967295E9))
            {
               throw new Error("Forbidden value (" + this.livingObject + ") on element livingObject.");
            }
            else
            {
               output.writeUnsignedInt(this.livingObject);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LivingObjectMessageRequestMessage(input);
      }
      
      public function deserializeAs_LivingObjectMessageRequestMessage(input:IDataInput) : void {
         var _val2:String = null;
         this.msgId = input.readShort();
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element of LivingObjectMessageRequestMessage.msgId.");
         }
         else
         {
            _parametersLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _parametersLen)
            {
               _val2 = input.readUTF();
               this.parameters.push(_val2);
               _i2++;
            }
            this.livingObject = input.readUnsignedInt();
            if((this.livingObject < 0) || (this.livingObject > 4.294967295E9))
            {
               throw new Error("Forbidden value (" + this.livingObject + ") on element of LivingObjectMessageRequestMessage.livingObject.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
