package com.ankamagames.dofus.network.messages.game.context.dungeon
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DungeonKeyRingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DungeonKeyRingMessage() {
         this.availables = new Vector.<uint>();
         this.unavailables = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6299;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var availables:Vector.<uint>;
      
      public var unavailables:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6299;
      }
      
      public function initDungeonKeyRingMessage(param1:Vector.<uint>=null, param2:Vector.<uint>=null) : DungeonKeyRingMessage {
         this.availables = param1;
         this.unavailables = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.availables = new Vector.<uint>();
         this.unavailables = new Vector.<uint>();
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
         this.serializeAs_DungeonKeyRingMessage(param1);
      }
      
      public function serializeAs_DungeonKeyRingMessage(param1:IDataOutput) : void {
         param1.writeShort(this.availables.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.availables.length)
         {
            if(this.availables[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.availables[_loc2_] + ") on element 1 (starting at 1) of availables.");
            }
            else
            {
               param1.writeShort(this.availables[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         param1.writeShort(this.unavailables.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.unavailables.length)
         {
            if(this.unavailables[_loc3_] < 0)
            {
               throw new Error("Forbidden value (" + this.unavailables[_loc3_] + ") on element 2 (starting at 1) of unavailables.");
            }
            else
            {
               param1.writeShort(this.unavailables[_loc3_]);
               _loc3_++;
               continue;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_DungeonKeyRingMessage(param1);
      }
      
      public function deserializeAs_DungeonKeyRingMessage(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1.readShort();
            if(_loc6_ < 0)
            {
               throw new Error("Forbidden value (" + _loc6_ + ") on elements of availables.");
            }
            else
            {
               this.availables.push(_loc6_);
               _loc3_++;
               continue;
            }
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readShort();
            if(_loc7_ < 0)
            {
               throw new Error("Forbidden value (" + _loc7_ + ") on elements of unavailables.");
            }
            else
            {
               this.unavailables.push(_loc7_);
               _loc5_++;
               continue;
            }
         }
      }
   }
}
