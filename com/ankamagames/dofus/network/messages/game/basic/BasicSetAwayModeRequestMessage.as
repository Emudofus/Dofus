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
      
      public function initBasicSetAwayModeRequestMessage(param1:Boolean=false, param2:Boolean=false) : BasicSetAwayModeRequestMessage {
         this.enable = param1;
         this.invisible = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.enable = false;
         this.invisible = false;
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
         this.serializeAs_BasicSetAwayModeRequestMessage(param1);
      }
      
      public function serializeAs_BasicSetAwayModeRequestMessage(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.enable);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.invisible);
         param1.writeByte(_loc2_);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BasicSetAwayModeRequestMessage(param1);
      }
      
      public function deserializeAs_BasicSetAwayModeRequestMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.enable = BooleanByteWrapper.getFlag(_loc2_,0);
         this.invisible = BooleanByteWrapper.getFlag(_loc2_,1);
      }
   }
}
