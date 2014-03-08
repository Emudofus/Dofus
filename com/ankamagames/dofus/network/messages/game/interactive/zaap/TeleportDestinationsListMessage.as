package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
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
      
      public function initTeleportDestinationsListMessage(teleporterType:uint=0, mapIds:Vector.<uint>=null, subAreaIds:Vector.<uint>=null, costs:Vector.<uint>=null, destTeleporterType:Vector.<uint>=null) : TeleportDestinationsListMessage {
         this.teleporterType = teleporterType;
         this.mapIds = mapIds;
         this.subAreaIds = subAreaIds;
         this.costs = costs;
         this.destTeleporterType = destTeleporterType;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_TeleportDestinationsListMessage(output);
      }
      
      public function serializeAs_TeleportDestinationsListMessage(output:IDataOutput) : void {
         output.writeByte(this.teleporterType);
         output.writeShort(this.mapIds.length);
         var _i2:uint = 0;
         while(_i2 < this.mapIds.length)
         {
            if(this.mapIds[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.mapIds[_i2] + ") on element 2 (starting at 1) of mapIds.");
            }
            else
            {
               output.writeInt(this.mapIds[_i2]);
               _i2++;
               continue;
            }
         }
         output.writeShort(this.subAreaIds.length);
         var _i3:uint = 0;
         while(_i3 < this.subAreaIds.length)
         {
            if(this.subAreaIds[_i3] < 0)
            {
               throw new Error("Forbidden value (" + this.subAreaIds[_i3] + ") on element 3 (starting at 1) of subAreaIds.");
            }
            else
            {
               output.writeShort(this.subAreaIds[_i3]);
               _i3++;
               continue;
            }
         }
         output.writeShort(this.costs.length);
         var _i4:uint = 0;
         while(_i4 < this.costs.length)
         {
            if(this.costs[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.costs[_i4] + ") on element 4 (starting at 1) of costs.");
            }
            else
            {
               output.writeShort(this.costs[_i4]);
               _i4++;
               continue;
            }
         }
         output.writeShort(this.destTeleporterType.length);
         var _i5:uint = 0;
         while(_i5 < this.destTeleporterType.length)
         {
            output.writeByte(this.destTeleporterType[_i5]);
            _i5++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TeleportDestinationsListMessage(input);
      }
      
      public function deserializeAs_TeleportDestinationsListMessage(input:IDataInput) : void {
         var _val2:uint = 0;
         var _val3:uint = 0;
         var _val4:uint = 0;
         var _val5:uint = 0;
         this.teleporterType = input.readByte();
         if(this.teleporterType < 0)
         {
            throw new Error("Forbidden value (" + this.teleporterType + ") on element of TeleportDestinationsListMessage.teleporterType.");
         }
         else
         {
            _mapIdsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _mapIdsLen)
            {
               _val2 = input.readInt();
               if(_val2 < 0)
               {
                  throw new Error("Forbidden value (" + _val2 + ") on elements of mapIds.");
               }
               else
               {
                  this.mapIds.push(_val2);
                  _i2++;
                  continue;
               }
            }
            _subAreaIdsLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _subAreaIdsLen)
            {
               _val3 = input.readShort();
               if(_val3 < 0)
               {
                  throw new Error("Forbidden value (" + _val3 + ") on elements of subAreaIds.");
               }
               else
               {
                  this.subAreaIds.push(_val3);
                  _i3++;
                  continue;
               }
            }
            _costsLen = input.readUnsignedShort();
            _i4 = 0;
            while(_i4 < _costsLen)
            {
               _val4 = input.readShort();
               if(_val4 < 0)
               {
                  throw new Error("Forbidden value (" + _val4 + ") on elements of costs.");
               }
               else
               {
                  this.costs.push(_val4);
                  _i4++;
                  continue;
               }
            }
            _destTeleporterTypeLen = input.readUnsignedShort();
            _i5 = 0;
            while(_i5 < _destTeleporterTypeLen)
            {
               _val5 = input.readByte();
               if(_val5 < 0)
               {
                  throw new Error("Forbidden value (" + _val5 + ") on elements of destTeleporterType.");
               }
               else
               {
                  this.destTeleporterType.push(_val5);
                  _i5++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
