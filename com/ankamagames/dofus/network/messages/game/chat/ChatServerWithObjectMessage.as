package com.ankamagames.dofus.network.messages.game.chat
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChatServerWithObjectMessage extends ChatServerMessage implements INetworkMessage
   {
      
      public function ChatServerWithObjectMessage() {
         this.objects = new Vector.<ObjectItem>();
         super();
      }
      
      public static const protocolId:uint = 883;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var objects:Vector.<ObjectItem>;
      
      override public function getMessageId() : uint {
         return 883;
      }
      
      public function initChatServerWithObjectMessage(channel:uint = 0, content:String = "", timestamp:uint = 0, fingerprint:String = "", senderId:int = 0, senderName:String = "", senderAccountId:int = 0, objects:Vector.<ObjectItem> = null) : ChatServerWithObjectMessage {
         super.initChatServerMessage(channel,content,timestamp,fingerprint,senderId,senderName,senderAccountId);
         this.objects = objects;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.objects = new Vector.<ObjectItem>();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ChatServerWithObjectMessage(output);
      }
      
      public function serializeAs_ChatServerWithObjectMessage(output:IDataOutput) : void {
         super.serializeAs_ChatServerMessage(output);
         output.writeShort(this.objects.length);
         var _i1:uint = 0;
         while(_i1 < this.objects.length)
         {
            (this.objects[_i1] as ObjectItem).serializeAs_ObjectItem(output);
            _i1++;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChatServerWithObjectMessage(input);
      }
      
      public function deserializeAs_ChatServerWithObjectMessage(input:IDataInput) : void {
         var _item1:ObjectItem = null;
         super.deserialize(input);
         var _objectsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _objectsLen)
         {
            _item1 = new ObjectItem();
            _item1.deserialize(input);
            this.objects.push(_item1);
            _i1++;
         }
      }
   }
}
