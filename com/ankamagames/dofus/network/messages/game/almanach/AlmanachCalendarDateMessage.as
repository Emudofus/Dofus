package com.ankamagames.dofus.network.messages.game.almanach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AlmanachCalendarDateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AlmanachCalendarDateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6341;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var date:int = 0;
      
      override public function getMessageId() : uint {
         return 6341;
      }
      
      public function initAlmanachCalendarDateMessage(date:int=0) : AlmanachCalendarDateMessage {
         this.date = date;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.date = 0;
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
         this.serializeAs_AlmanachCalendarDateMessage(output);
      }
      
      public function serializeAs_AlmanachCalendarDateMessage(output:IDataOutput) : void {
         output.writeInt(this.date);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlmanachCalendarDateMessage(input);
      }
      
      public function deserializeAs_AlmanachCalendarDateMessage(input:IDataInput) : void {
         this.date = input.readInt();
      }
   }
}
