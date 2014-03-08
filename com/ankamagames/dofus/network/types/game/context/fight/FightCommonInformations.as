package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
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
      
      public function initFightCommonInformations(param1:int=0, param2:uint=0, param3:Vector.<FightTeamInformations>=null, param4:Vector.<uint>=null, param5:Vector.<FightOptionsInformations>=null) : FightCommonInformations {
         this.fightId = param1;
         this.fightType = param2;
         this.fightTeams = param3;
         this.fightTeamsPositions = param4;
         this.fightTeamsOptions = param5;
         return this;
      }
      
      public function reset() : void {
         this.fightId = 0;
         this.fightType = 0;
         this.fightTeams = new Vector.<FightTeamInformations>();
         this.fightTeamsPositions = new Vector.<uint>();
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightCommonInformations(param1);
      }
      
      public function serializeAs_FightCommonInformations(param1:IDataOutput) : void {
         param1.writeInt(this.fightId);
         param1.writeByte(this.fightType);
         param1.writeShort(this.fightTeams.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.fightTeams.length)
         {
            param1.writeShort((this.fightTeams[_loc2_] as FightTeamInformations).getTypeId());
            (this.fightTeams[_loc2_] as FightTeamInformations).serialize(param1);
            _loc2_++;
         }
         param1.writeShort(this.fightTeamsPositions.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.fightTeamsPositions.length)
         {
            if(this.fightTeamsPositions[_loc3_] < 0 || this.fightTeamsPositions[_loc3_] > 559)
            {
               throw new Error("Forbidden value (" + this.fightTeamsPositions[_loc3_] + ") on element 4 (starting at 1) of fightTeamsPositions.");
            }
            else
            {
               param1.writeShort(this.fightTeamsPositions[_loc3_]);
               _loc3_++;
               continue;
            }
         }
         param1.writeShort(this.fightTeamsOptions.length);
         var _loc4_:uint = 0;
         while(_loc4_ < this.fightTeamsOptions.length)
         {
            (this.fightTeamsOptions[_loc4_] as FightOptionsInformations).serializeAs_FightOptionsInformations(param1);
            _loc4_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightCommonInformations(param1);
      }
      
      public function deserializeAs_FightCommonInformations(param1:IDataInput) : void {
         var _loc8_:uint = 0;
         var _loc9_:FightTeamInformations = null;
         var _loc10_:uint = 0;
         var _loc11_:FightOptionsInformations = null;
         this.fightId = param1.readInt();
         this.fightType = param1.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of FightCommonInformations.fightType.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc8_ = param1.readUnsignedShort();
               _loc9_ = ProtocolTypeManager.getInstance(FightTeamInformations,_loc8_);
               _loc9_.deserialize(param1);
               this.fightTeams.push(_loc9_);
               _loc3_++;
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc10_ = param1.readShort();
               if(_loc10_ < 0 || _loc10_ > 559)
               {
                  throw new Error("Forbidden value (" + _loc10_ + ") on elements of fightTeamsPositions.");
               }
               else
               {
                  this.fightTeamsPositions.push(_loc10_);
                  _loc5_++;
                  continue;
               }
            }
            _loc6_ = param1.readUnsignedShort();
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc11_ = new FightOptionsInformations();
               _loc11_.deserialize(param1);
               this.fightTeamsOptions.push(_loc11_);
               _loc7_++;
            }
            return;
         }
      }
   }
}
