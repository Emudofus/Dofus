package com.ankamagames.dofus.network.messages.game.startup
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class StartupActionFinishedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StartupActionFinishedMessage() {
         super();
      }
      
      public static const protocolId:uint = 1304;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var success:Boolean = false;
      
      public var actionId:uint = 0;
      
      public var automaticAction:Boolean = false;
      
      override public function getMessageId() : uint {
         return 1304;
      }
      
      public function initStartupActionFinishedMessage(param1:Boolean=false, param2:uint=0, param3:Boolean=false) : StartupActionFinishedMessage {
         this.success = param1;
         this.actionId = param2;
         this.automaticAction = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.success = false;
         this.actionId = 0;
         this.automaticAction = false;
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
         this.serializeAs_StartupActionFinishedMessage(param1);
      }
      
      public function serializeAs_StartupActionFinishedMessage(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.success);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.automaticAction);
         param1.writeByte(_loc2_);
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         else
         {
            param1.writeInt(this.actionId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_StartupActionFinishedMessage(param1);
      }
      
      public function deserializeAs_StartupActionFinishedMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.success = BooleanByteWrapper.getFlag(_loc2_,0);
         this.automaticAction = BooleanByteWrapper.getFlag(_loc2_,1);
         this.actionId = param1.readInt();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of StartupActionFinishedMessage.actionId.");
         }
         else
         {
            return;
         }
      }
   }
}
