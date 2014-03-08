package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TeleportDestinationsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TeleportDestinationsListMessage() {
         this.mapIds = new Vector.<uint>();
         this.subAreaIds = new Vector.<uint>();
         this.costs = new Vector.<uint>();
         this.destTeleporterType = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5960;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var teleporterType:uint = 0;
      
      public var mapIds:Vector.<uint>;
      
      public var subAreaIds:Vector.<uint>;
      
      public var costs:Vector.<uint>;
      
      public var destTeleporterType:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 5960;
      }
      
      public function initTeleportDestinationsListMessage(param1:uint=0, param2:Vector.<uint>=null, param3:Vector.<uint>=null, param4:Vector.<uint>=null, param5:Vector.<uint>=null) : TeleportDestinationsListMessage {
         this.teleporterType = param1;
         this.mapIds = param2;
         this.subAreaIds = param3;
         this.costs = param4;
         this.destTeleporterType = param5;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.teleporterType = 0;
         this.mapIds = new Vector.<uint>();
         this.subAreaIds = new Vector.<uint>();
         this.costs = new Vector.<uint>();
         this.destTeleporterType = new Vector.<uint>();
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
         this.serializeAs_TeleportDestinationsListMessage(param1);
      }
      
      public function serializeAs_TeleportDestinationsListMessage(param1:IDataOutput) : void {
         param1.writeByte(this.teleporterType);
         param1.writeShort(this.mapIds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.mapIds.length)
         {
            if(this.mapIds[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.mapIds[_loc2_] + ") on element 2 (starting at 1) of mapIds.");
            }
            else
            {
               param1.writeInt(this.mapIds[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         param1.writeShort(this.subAreaIds.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.subAreaIds.length)
         {
            if(this.subAreaIds[_loc3_] < 0)
            {
               throw new Error("Forbidden value (" + this.subAreaIds[_loc3_] + ") on element 3 (starting at 1) of subAreaIds.");
            }
            else
            {
               param1.writeShort(this.subAreaIds[_loc3_]);
               _loc3_++;
               continue;
            }
         }
         param1.writeShort(this.costs.length);
         var _loc4_:uint = 0;
         while(_loc4_ < this.costs.length)
         {
            if(this.costs[_loc4_] < 0)
            {
               throw new Error("Forbidden value (" + this.costs[_loc4_] + ") on element 4 (starting at 1) of costs.");
            }
            else
            {
               param1.writeShort(this.costs[_loc4_]);
               _loc4_++;
               continue;
            }
         }
         param1.writeShort(this.destTeleporterType.length);
         var _loc5_:uint = 0;
         while(_loc5_ < this.destTeleporterType.length)
         {
            param1.writeByte(this.destTeleporterType[_loc5_]);
            _loc5_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TeleportDestinationsListMessage(param1);
      }
      
      public function deserializeAs_TeleportDestinationsListMessage(param1:IDataInput) : void {
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         this.teleporterType = param1.readByte();
         if(this.teleporterType < 0)
         {
            throw new Error("Forbidden value (" + this.teleporterType + ") on element of TeleportDestinationsListMessage.teleporterType.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc10_ = param1.readInt();
               if(_loc10_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc10_ + ") on elements of mapIds.");
               }
               else
               {
                  this.mapIds.push(_loc10_);
                  _loc3_++;
                  continue;
               }
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc11_ = param1.readShort();
               if(_loc11_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc11_ + ") on elements of subAreaIds.");
               }
               else
               {
                  this.subAreaIds.push(_loc11_);
                  _loc5_++;
                  continue;
               }
            }
            _loc6_ = param1.readUnsignedShort();
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc12_ = param1.readShort();
               if(_loc12_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc12_ + ") on elements of costs.");
               }
               else
               {
                  this.costs.push(_loc12_);
                  _loc7_++;
                  continue;
               }
            }
            _loc8_ = param1.readUnsignedShort();
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               _loc13_ = param1.readByte();
               if(_loc13_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc13_ + ") on elements of destTeleporterType.");
               }
               else
               {
                  this.destTeleporterType.push(_loc13_);
                  _loc9_++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
