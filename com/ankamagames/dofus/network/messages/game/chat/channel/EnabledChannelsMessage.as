package com.ankamagames.dofus.network.messages.game.chat.channel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class EnabledChannelsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function EnabledChannelsMessage() {
         this.channels = new Vector.<uint>();
         this.disallowed = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 892;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var channels:Vector.<uint>;
      
      public var disallowed:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 892;
      }
      
      public function initEnabledChannelsMessage(param1:Vector.<uint>=null, param2:Vector.<uint>=null) : EnabledChannelsMessage {
         this.channels = param1;
         this.disallowed = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.channels = new Vector.<uint>();
         this.disallowed = new Vector.<uint>();
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
         this.serializeAs_EnabledChannelsMessage(param1);
      }
      
      public function serializeAs_EnabledChannelsMessage(param1:IDataOutput) : void {
         param1.writeShort(this.channels.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.channels.length)
         {
            param1.writeByte(this.channels[_loc2_]);
            _loc2_++;
         }
         param1.writeShort(this.disallowed.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.disallowed.length)
         {
            param1.writeByte(this.disallowed[_loc3_]);
            _loc3_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_EnabledChannelsMessage(param1);
      }
      
      public function deserializeAs_EnabledChannelsMessage(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1.readByte();
            if(_loc6_ < 0)
            {
               throw new Error("Forbidden value (" + _loc6_ + ") on elements of channels.");
            }
            else
            {
               this.channels.push(_loc6_);
               _loc3_++;
               continue;
            }
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readByte();
            if(_loc7_ < 0)
            {
               throw new Error("Forbidden value (" + _loc7_ + ") on elements of disallowed.");
            }
            else
            {
               this.disallowed.push(_loc7_);
               _loc5_++;
               continue;
            }
         }
      }
   }
}
