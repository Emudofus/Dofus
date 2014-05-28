package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
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
      
      public function initKohUpdateMessage(alliances:Vector.<AllianceInformations> = null, allianceNbMembers:Vector.<uint> = null, allianceRoundWeigth:Vector.<uint> = null, allianceMatchScore:Vector.<uint> = null, allianceMapWinner:BasicAllianceInformations = null, allianceMapWinnerScore:uint = 0, allianceMapMyAllianceScore:uint = 0, nextTickTime:Number = 0) : KohUpdateMessage {
         this.alliances = alliances;
         this.allianceNbMembers = allianceNbMembers;
         this.allianceRoundWeigth = allianceRoundWeigth;
         this.allianceMatchScore = allianceMatchScore;
         this.allianceMapWinner = allianceMapWinner;
         this.allianceMapWinnerScore = allianceMapWinnerScore;
         this.allianceMapMyAllianceScore = allianceMapMyAllianceScore;
         this.nextTickTime = nextTickTime;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_KohUpdateMessage(output);
      }
      
      public function serializeAs_KohUpdateMessage(output:IDataOutput) : void {
         output.writeShort(this.alliances.length);
         var _i1:uint = 0;
         while(_i1 < this.alliances.length)
         {
            (this.alliances[_i1] as AllianceInformations).serializeAs_AllianceInformations(output);
            _i1++;
         }
         output.writeShort(this.allianceNbMembers.length);
         var _i2:uint = 0;
         while(_i2 < this.allianceNbMembers.length)
         {
            if(this.allianceNbMembers[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.allianceNbMembers[_i2] + ") on element 2 (starting at 1) of allianceNbMembers.");
            }
            else
            {
               output.writeShort(this.allianceNbMembers[_i2]);
               _i2++;
               continue;
            }
         }
         output.writeShort(this.allianceRoundWeigth.length);
         var _i3:uint = 0;
         while(_i3 < this.allianceRoundWeigth.length)
         {
            if(this.allianceRoundWeigth[_i3] < 0)
            {
               throw new Error("Forbidden value (" + this.allianceRoundWeigth[_i3] + ") on element 3 (starting at 1) of allianceRoundWeigth.");
            }
            else
            {
               output.writeInt(this.allianceRoundWeigth[_i3]);
               _i3++;
               continue;
            }
         }
         output.writeShort(this.allianceMatchScore.length);
         var _i4:uint = 0;
         while(_i4 < this.allianceMatchScore.length)
         {
            if(this.allianceMatchScore[_i4] < 0)
            {
               throw new Error("Forbidden value (" + this.allianceMatchScore[_i4] + ") on element 4 (starting at 1) of allianceMatchScore.");
            }
            else
            {
               output.writeByte(this.allianceMatchScore[_i4]);
               _i4++;
               continue;
            }
         }
         this.allianceMapWinner.serializeAs_BasicAllianceInformations(output);
         if(this.allianceMapWinnerScore < 0)
         {
            throw new Error("Forbidden value (" + this.allianceMapWinnerScore + ") on element allianceMapWinnerScore.");
         }
         else
         {
            output.writeInt(this.allianceMapWinnerScore);
            if(this.allianceMapMyAllianceScore < 0)
            {
               throw new Error("Forbidden value (" + this.allianceMapMyAllianceScore + ") on element allianceMapMyAllianceScore.");
            }
            else
            {
               output.writeInt(this.allianceMapMyAllianceScore);
               if(this.nextTickTime < 0)
               {
                  throw new Error("Forbidden value (" + this.nextTickTime + ") on element nextTickTime.");
               }
               else
               {
                  output.writeDouble(this.nextTickTime);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_KohUpdateMessage(input);
      }
      
      public function deserializeAs_KohUpdateMessage(input:IDataInput) : void {
         var _item1:AllianceInformations = null;
         var _val2:uint = 0;
         var _val3:uint = 0;
         var _val4:uint = 0;
         var _alliancesLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _alliancesLen)
         {
            _item1 = new AllianceInformations();
            _item1.deserialize(input);
            this.alliances.push(_item1);
            _i1++;
         }
         var _allianceNbMembersLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _allianceNbMembersLen)
         {
            _val2 = input.readShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of allianceNbMembers.");
            }
            else
            {
               this.allianceNbMembers.push(_val2);
               _i2++;
               continue;
            }
         }
         var _allianceRoundWeigthLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3 < _allianceRoundWeigthLen)
         {
            _val3 = input.readInt();
            if(_val3 < 0)
            {
               throw new Error("Forbidden value (" + _val3 + ") on elements of allianceRoundWeigth.");
            }
            else
            {
               this.allianceRoundWeigth.push(_val3);
               _i3++;
               continue;
            }
         }
         var _allianceMatchScoreLen:uint = input.readUnsignedShort();
         var _i4:uint = 0;
         while(_i4 < _allianceMatchScoreLen)
         {
            _val4 = input.readByte();
            if(_val4 < 0)
            {
               throw new Error("Forbidden value (" + _val4 + ") on elements of allianceMatchScore.");
            }
            else
            {
               this.allianceMatchScore.push(_val4);
               _i4++;
               continue;
            }
         }
         this.allianceMapWinner = new BasicAllianceInformations();
         this.allianceMapWinner.deserialize(input);
         this.allianceMapWinnerScore = input.readInt();
         if(this.allianceMapWinnerScore < 0)
         {
            throw new Error("Forbidden value (" + this.allianceMapWinnerScore + ") on element of KohUpdateMessage.allianceMapWinnerScore.");
         }
         else
         {
            this.allianceMapMyAllianceScore = input.readInt();
            if(this.allianceMapMyAllianceScore < 0)
            {
               throw new Error("Forbidden value (" + this.allianceMapMyAllianceScore + ") on element of KohUpdateMessage.allianceMapMyAllianceScore.");
            }
            else
            {
               this.nextTickTime = input.readDouble();
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
