package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class BasicSetAwayModeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicSetAwayModeRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5665;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      public var invisible:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5665;
      }
      
      public function initBasicSetAwayModeRequestMessage(enable:Boolean = false, invisible:Boolean = false) : BasicSetAwayModeRequestMessage {
         this.enable = enable;
         this.invisible = invisible;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.enable = false;
         this.invisible = false;
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
         this.serializeAs_BasicSetAwayModeRequestMessage(output);
      }
      
      public function serializeAs_BasicSetAwayModeRequestMessage(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.enable);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.invisible);
         output.writeByte(_box0);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicSetAwayModeRequestMessage(input);
      }
      
      public function deserializeAs_BasicSetAwayModeRequestMessage(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.enable = BooleanByteWrapper.getFlag(_box0,0);
         this.invisible = BooleanByteWrapper.getFlag(_box0,1);
      }
   }
}
