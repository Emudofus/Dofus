package com.ankamagames.dofus.network.messages.connection.search
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AcquaintanceServerListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AcquaintanceServerListMessage() {
         this.servers = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 6142;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var servers:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 6142;
      }
      
      public function initAcquaintanceServerListMessage(servers:Vector.<int> = null) : AcquaintanceServerListMessage {
         this.servers = servers;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.servers = new Vector.<int>();
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
         this.serializeAs_AcquaintanceServerListMessage(output);
      }
      
      public function serializeAs_AcquaintanceServerListMessage(output:IDataOutput) : void {
         output.writeShort(this.servers.length);
         var _i1:uint = 0;
         while(_i1 < this.servers.length)
         {
            output.writeShort(this.servers[_i1]);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AcquaintanceServerListMessage(input);
      }
      
      public function deserializeAs_AcquaintanceServerListMessage(input:IDataInput) : void {
         var _val1:* = 0;
         var _serversLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _serversLen)
         {
            _val1 = input.readShort();
            this.servers.push(_val1);
            _i1++;
         }
      }
   }
}
