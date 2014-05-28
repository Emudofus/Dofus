package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class IgnoredDeleteResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IgnoredDeleteResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5677;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var success:Boolean = false;
      
      public var name:String = "";
      
      public var session:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5677;
      }
      
      public function initIgnoredDeleteResultMessage(success:Boolean = false, name:String = "", session:Boolean = false) : IgnoredDeleteResultMessage {
         this.success = success;
         this.name = name;
         this.session = session;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.success = false;
         this.name = "";
         this.session = false;
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
         this.serializeAs_IgnoredDeleteResultMessage(output);
      }
      
      public function serializeAs_IgnoredDeleteResultMessage(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.success);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.session);
         output.writeByte(_box0);
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IgnoredDeleteResultMessage(input);
      }
      
      public function deserializeAs_IgnoredDeleteResultMessage(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.success = BooleanByteWrapper.getFlag(_box0,0);
         this.session = BooleanByteWrapper.getFlag(_box0,1);
         this.name = input.readUTF();
      }
   }
}
