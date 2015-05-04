package com.ankamagames.dofus.network.messages.game.almanach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AlmanachCalendarDateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AlmanachCalendarDateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6341;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var date:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6341;
      }
      
      public function initAlmanachCalendarDateMessage(param1:int = 0) : AlmanachCalendarDateMessage
      {
         this.date = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.date = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AlmanachCalendarDateMessage(param1);
      }
      
      public function serializeAs_AlmanachCalendarDateMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.date);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AlmanachCalendarDateMessage(param1);
      }
      
      public function deserializeAs_AlmanachCalendarDateMessage(param1:ICustomDataInput) : void
      {
         this.date = param1.readInt();
      }
   }
}
