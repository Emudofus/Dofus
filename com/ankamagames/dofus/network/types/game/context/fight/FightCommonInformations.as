package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class FightCommonInformations extends Object implements INetworkType
   {
      
      public function FightCommonInformations() {
         this.fightTeams = new Vector.<FightTeamInformations>();
         this.fightTeamsPositions = new Vector.<uint>();
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>();
         super();
      }
      
      public static const protocolId:uint = 43;
      
      public var fightId:int = 0;
      
      public var fightType:uint = 0;
      
      public var fightTeams:Vector.<FightTeamInformations>;
      
      public var fightTeamsPositions:Vector.<uint>;
      
      public var fightTeamsOptions:Vector.<FightOptionsInformations>;
      
      public function getTypeId() : uint {
         return 43;
      }
      
      public function initFightCommonInformations(fightId:int=0, fightType:uint=0, fightTeams:Vector.<FightTeamInformations>=null, fightTeamsPositions:Vector.<uint>=null, fightTeamsOptions:Vector.<FightOptionsInformations>=null) : FightCommonInformations {
         this.fightId = fightId;
         this.fightType = fightType;
         this.fightTeams = fightTeams;
         this.fightTeamsPositions = fightTeamsPositions;
         this.fightTeamsOptions = fightTeamsOptions;
         return this;
      }
      
      public function reset() : void {
         this.fightId = 0;
         this.fightType = 0;
         this.fightTeams = new Vector.<FightTeamInformations>();
         this.fightTeamsPositions = new Vector.<uint>();
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightCommonInformations(output);
      }
      
      public function serializeAs_FightCommonInformations(output:IDataOutput) : void {
         output.writeInt(this.fightId);
         output.writeByte(this.fightType);
         output.writeShort(this.fightTeams.length);
         var _i3:uint = 0;
         while(_i3 < this.fightTeams.length)
         {
            output.writeShort((this.fightTeams[_i3] as FightTeamInformations).getTypeId());
            (this.fightTeams[_i3] as FightTeamInformations).serialize(output);
            _i3++;
         }
         output.writeShort(this.fightTeamsPositions.length);
         var _i4:uint = 0;
         while(_i4 < this.fightTeamsPositions.length)
         {
            if((this.fightTeamsPositions[_i4] < 0) || (this.fightTeamsPositions[_i4] > 559))
            {
               throw new Error("Forbidden value (" + this.fightTeamsPositions[_i4] + ") on element 4 (starting at 1) of fightTeamsPositions.");
            }
            else
            {
               output.writeShort(this.fightTeamsPositions[_i4]);
               _i4++;
               continue;
            }
         }
         output.writeShort(this.fightTeamsOptions.length);
         var _i5:uint = 0;
         while(_i5 < this.fightTeamsOptions.length)
         {
            (this.fightTeamsOptions[_i5] as FightOptionsInformations).serializeAs_FightOptionsInformations(output);
            _i5++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightCommonInformations(input);
      }
      
      public function deserializeAs_FightCommonInformations(input:IDataInput) : void {
         var _id3:uint = 0;
         var _item3:FightTeamInformations = null;
         var _val4:uint = 0;
         var _item5:FightOptionsInformations = null;
         this.fightId = input.readInt();
         this.fightType = input.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of FightCommonInformations.fightType.");
         }
         else
         {
            _fightTeamsLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _fightTeamsLen)
            {
               _id3 = input.readUnsignedShort();
               _item3 = ProtocolTypeManager.getInstance(FightTeamInformations,_id3);
               _item3.deserialize(input);
               this.fightTeams.push(_item3);
               _i3++;
            }
            _fightTeamsPositionsLen = input.readUnsignedShort();
            _i4 = 0;
            while(_i4 < _fightTeamsPositionsLen)
            {
               _val4 = input.readShort();
               if((_val4 < 0) || (_val4 > 559))
               {
                  throw new Error("Forbidden value (" + _val4 + ") on elements of fightTeamsPositions.");
               }
               else
               {
                  this.fightTeamsPositions.push(_val4);
                  _i4++;
                  continue;
               }
            }
            _fightTeamsOptionsLen = input.readUnsignedShort();
            _i5 = 0;
            while(_i5 < _fightTeamsOptionsLen)
            {
               _item5 = new FightOptionsInformations();
               _item5.deserialize(input);
               this.fightTeamsOptions.push(_item5);
               _i5++;
            }
            return;
         }
      }
   }
}
