package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SelectedServerDataExtendedMessage extends SelectedServerDataMessage implements INetworkMessage
   {
      
      public function SelectedServerDataExtendedMessage() {
         this.serverIds = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6469;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var serverIds:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6469;
      }
      
      public function initSelectedServerDataExtendedMessage(serverId:int=0, address:String="", port:uint=0, canCreateNewCharacter:Boolean=false, ticket:String="", serverIds:Vector.<uint>=null) : SelectedServerDataExtendedMessage {
         super.initSelectedServerDataMessage(serverId,address,port,canCreateNewCharacter,ticket);
         this.serverIds = serverIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.serverIds = new Vector.<uint>();
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
         this.serializeAs_SelectedServerDataExtendedMessage(output);
      }
      
      public function serializeAs_SelectedServerDataExtendedMessage(output:IDataOutput) : void {
         super.serializeAs_SelectedServerDataMessage(output);
         output.writeShort(this.serverIds.length);
         var _i1:uint = 0;
         while(_i1 < this.serverIds.length)
         {
            if(this.serverIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.serverIds[_i1] + ") on element 1 (starting at 1) of serverIds.");
            }
            else
            {
               output.writeShort(this.serverIds[_i1]);
               _i1++;
               continue;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SelectedServerDataExtendedMessage(input);
      }
      
      public function deserializeAs_SelectedServerDataExtendedMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         super.deserialize(input);
         var _serverIdsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _serverIdsLen)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of serverIds.");
            }
            else
            {
               this.serverIds.push(_val1);
               _i1++;
               continue;
            }
         }
      }
   }
}
