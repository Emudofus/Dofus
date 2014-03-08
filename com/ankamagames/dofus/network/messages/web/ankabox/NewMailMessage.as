package com.ankamagames.dofus.network.messages.web.ankabox
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NewMailMessage extends MailStatusMessage implements INetworkMessage
   {
      
      public function NewMailMessage() {
         this.sendersAccountId = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6292;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var sendersAccountId:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6292;
      }
      
      public function initNewMailMessage(param1:uint=0, param2:uint=0, param3:Vector.<uint>=null) : NewMailMessage {
         super.initMailStatusMessage(param1,param2);
         this.sendersAccountId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.sendersAccountId = new Vector.<uint>();
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_NewMailMessage(param1);
      }
      
      public function serializeAs_NewMailMessage(param1:IDataOutput) : void {
         super.serializeAs_MailStatusMessage(param1);
         param1.writeShort(this.sendersAccountId.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.sendersAccountId.length)
         {
            if(this.sendersAccountId[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.sendersAccountId[_loc2_] + ") on element 1 (starting at 1) of sendersAccountId.");
            }
            else
            {
               param1.writeInt(this.sendersAccountId[_loc2_]);
               _loc2_++;
               continue;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_NewMailMessage(param1);
      }
      
      public function deserializeAs_NewMailMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInt();
            if(_loc4_ < 0)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of sendersAccountId.");
            }
            else
            {
               this.sendersAccountId.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
      }
   }
}
