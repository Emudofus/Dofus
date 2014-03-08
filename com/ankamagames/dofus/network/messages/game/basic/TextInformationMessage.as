package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TextInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TextInformationMessage() {
         this.parameters = new Vector.<String>();
         super();
      }
      
      public static const protocolId:uint = 780;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var msgType:uint = 0;
      
      public var msgId:uint = 0;
      
      public var parameters:Vector.<String>;
      
      override public function getMessageId() : uint {
         return 780;
      }
      
      public function initTextInformationMessage(param1:uint=0, param2:uint=0, param3:Vector.<String>=null) : TextInformationMessage {
         this.msgType = param1;
         this.msgId = param2;
         this.parameters = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.msgType = 0;
         this.msgId = 0;
         this.parameters = new Vector.<String>();
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
         this.serializeAs_TextInformationMessage(param1);
      }
      
      public function serializeAs_TextInformationMessage(param1:IDataOutput) : void {
         param1.writeByte(this.msgType);
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
         }
         else
         {
            param1.writeShort(this.msgId);
            param1.writeShort(this.parameters.length);
            _loc2_ = 0;
            while(_loc2_ < this.parameters.length)
            {
               param1.writeUTF(this.parameters[_loc2_]);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TextInformationMessage(param1);
      }
      
      public function deserializeAs_TextInformationMessage(param1:IDataInput) : void {
         var _loc4_:String = null;
         this.msgType = param1.readByte();
         if(this.msgType < 0)
         {
            throw new Error("Forbidden value (" + this.msgType + ") on element of TextInformationMessage.msgType.");
         }
         else
         {
            this.msgId = param1.readShort();
            if(this.msgId < 0)
            {
               throw new Error("Forbidden value (" + this.msgId + ") on element of TextInformationMessage.msgId.");
            }
            else
            {
               _loc2_ = param1.readUnsignedShort();
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = param1.readUTF();
                  this.parameters.push(_loc4_);
                  _loc3_++;
               }
               return;
            }
         }
      }
   }
}
