package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class KohUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KohUpdateMessage() {
         this.alliances = new Vector.<AllianceInformations>();
         this.allianceNbMembers = new Vector.<uint>();
         this.allianceRoundWeigth = new Vector.<uint>();
         this.allianceMatchScore = new Vector.<uint>();
         this.allianceMapWinner = new BasicAllianceInformations();
         super();
      }
      
      public static const protocolId:uint = 6439;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var alliances:Vector.<AllianceInformations>;
      
      public var allianceNbMembers:Vector.<uint>;
      
      public var allianceRoundWeigth:Vector.<uint>;
      
      public var allianceMatchScore:Vector.<uint>;
      
      public var allianceMapWinner:BasicAllianceInformations;
      
      public var allianceMapWinnerScore:uint = 0;
      
      public var allianceMapMyAllianceScore:uint = 0;
      
      public var nextTickTime:Number = 0;
      
      override public function getMessageId() : uint {
         return 6439;
      }
      
      public function initKohUpdateMessage(param1:Vector.<AllianceInformations>=null, param2:Vector.<uint>=null, param3:Vector.<uint>=null, param4:Vector.<uint>=null, param5:BasicAllianceInformations=null, param6:uint=0, param7:uint=0, param8:Number=0) : KohUpdateMessage {
         this.alliances = param1;
         this.allianceNbMembers = param2;
         this.allianceRoundWeigth = param3;
         this.allianceMatchScore = param4;
         this.allianceMapWinner = param5;
         this.allianceMapWinnerScore = param6;
         this.allianceMapMyAllianceScore = param7;
         this.nextTickTime = param8;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.alliances = new Vector.<AllianceInformations>();
         this.allianceNbMembers = new Vector.<uint>();
         this.allianceRoundWeigth = new Vector.<uint>();
         this.allianceMatchScore = new Vector.<uint>();
         this.allianceMapWinner = new BasicAllianceInformations();
         this.allianceMapMyAllianceScore = 0;
         this.nextTickTime = 0;
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
         this.serializeAs_KohUpdateMessage(param1);
      }
      
      public function serializeAs_KohUpdateMessage(param1:IDataOutput) : void {
         param1.writeShort(this.alliances.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.alliances.length)
         {
            (this.alliances[_loc2_] as AllianceInformations).serializeAs_AllianceInformations(param1);
            _loc2_++;
         }
         param1.writeShort(this.allianceNbMembers.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.allianceNbMembers.length)
         {
            if(this.allianceNbMembers[_loc3_] < 0)
            {
               throw new Error("Forbidden value (" + this.allianceNbMembers[_loc3_] + ") on element 2 (starting at 1) of allianceNbMembers.");
            }
            else
            {
               param1.writeShort(this.allianceNbMembers[_loc3_]);
               _loc3_++;
               continue;
            }
         }
         param1.writeShort(this.allianceRoundWeigth.length);
         var _loc4_:uint = 0;
         while(_loc4_ < this.allianceRoundWeigth.length)
         {
            if(this.allianceRoundWeigth[_loc4_] < 0)
            {
               throw new Error("Forbidden value (" + this.allianceRoundWeigth[_loc4_] + ") on element 3 (starting at 1) of allianceRoundWeigth.");
            }
            else
            {
               param1.writeInt(this.allianceRoundWeigth[_loc4_]);
               _loc4_++;
               continue;
            }
         }
         param1.writeShort(this.allianceMatchScore.length);
         var _loc5_:uint = 0;
         while(_loc5_ < this.allianceMatchScore.length)
         {
            if(this.allianceMatchScore[_loc5_] < 0)
            {
               throw new Error("Forbidden value (" + this.allianceMatchScore[_loc5_] + ") on element 4 (starting at 1) of allianceMatchScore.");
            }
            else
            {
               param1.writeByte(this.allianceMatchScore[_loc5_]);
               _loc5_++;
               continue;
            }
         }
         this.allianceMapWinner.serializeAs_BasicAllianceInformations(param1);
         if(this.allianceMapWinnerScore < 0)
         {
            throw new Error("Forbidden value (" + this.allianceMapWinnerScore + ") on element allianceMapWinnerScore.");
         }
         else
         {
            param1.writeInt(this.allianceMapWinnerScore);
            if(this.allianceMapMyAllianceScore < 0)
            {
               throw new Error("Forbidden value (" + this.allianceMapMyAllianceScore + ") on element allianceMapMyAllianceScore.");
            }
            else
            {
               param1.writeInt(this.allianceMapMyAllianceScore);
               if(this.nextTickTime < 0)
               {
                  throw new Error("Forbidden value (" + this.nextTickTime + ") on element nextTickTime.");
               }
               else
               {
                  param1.writeDouble(this.nextTickTime);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_KohUpdateMessage(param1);
      }
      
      public function deserializeAs_KohUpdateMessage(param1:IDataInput) : void {
         var _loc10_:AllianceInformations = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc10_ = new AllianceInformations();
            _loc10_.deserialize(param1);
            this.alliances.push(_loc10_);
            _loc3_++;
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc11_ = param1.readShort();
            if(_loc11_ < 0)
            {
               throw new Error("Forbidden value (" + _loc11_ + ") on elements of allianceNbMembers.");
            }
            else
            {
               this.allianceNbMembers.push(_loc11_);
               _loc5_++;
               continue;
            }
         }
         var _loc6_:uint = param1.readUnsignedShort();
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_)
         {
            _loc12_ = param1.readInt();
            if(_loc12_ < 0)
            {
               throw new Error("Forbidden value (" + _loc12_ + ") on elements of allianceRoundWeigth.");
            }
            else
            {
               this.allianceRoundWeigth.push(_loc12_);
               _loc7_++;
               continue;
            }
         }
         var _loc8_:uint = param1.readUnsignedShort();
         var _loc9_:uint = 0;
         while(_loc9_ < _loc8_)
         {
            _loc13_ = param1.readByte();
            if(_loc13_ < 0)
            {
               throw new Error("Forbidden value (" + _loc13_ + ") on elements of allianceMatchScore.");
            }
            else
            {
               this.allianceMatchScore.push(_loc13_);
               _loc9_++;
               continue;
            }
         }
         this.allianceMapWinner = new BasicAllianceInformations();
         this.allianceMapWinner.deserialize(param1);
         this.allianceMapWinnerScore = param1.readInt();
         if(this.allianceMapWinnerScore < 0)
         {
            throw new Error("Forbidden value (" + this.allianceMapWinnerScore + ") on element of KohUpdateMessage.allianceMapWinnerScore.");
         }
         else
         {
            this.allianceMapMyAllianceScore = param1.readInt();
            if(this.allianceMapMyAllianceScore < 0)
            {
               throw new Error("Forbidden value (" + this.allianceMapMyAllianceScore + ") on element of KohUpdateMessage.allianceMapMyAllianceScore.");
            }
            else
            {
               this.nextTickTime = param1.readDouble();
               if(this.nextTickTime < 0)
               {
                  throw new Error("Forbidden value (" + this.nextTickTime + ") on element of KohUpdateMessage.nextTickTime.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
