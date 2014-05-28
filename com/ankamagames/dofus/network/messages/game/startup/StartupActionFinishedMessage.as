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
      
      public function initStartupActionFinishedMessage(success:Boolean = false, actionId:uint = 0, automaticAction:Boolean = false) : StartupActionFinishedMessage {
         this.success = success;
         this.actionId = actionId;
         this.automaticAction = automaticAction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.success = false;
         this.actionId = 0;
         this.automaticAction = false;
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
         this.serializeAs_StartupActionFinishedMessage(output);
      }
      
      public function serializeAs_StartupActionFinishedMessage(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.success);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.automaticAction);
         output.writeByte(_box0);
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         else
         {
            output.writeInt(this.actionId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_StartupActionFinishedMessage(input);
      }
      
      public function deserializeAs_StartupActionFinishedMessage(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.success = BooleanByteWrapper.getFlag(_box0,0);
         this.automaticAction = BooleanByteWrapper.getFlag(_box0,1);
         this.actionId = input.readInt();
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
