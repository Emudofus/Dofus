package com.ankamagames.dofus.internalDatacenter.quest
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStep;
    import com.ankamagames.dofus.types.enums.TreasureHuntStepTypeEnum;
    import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFollowDirectionToPOI;
    import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFollowDirection;
    import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFight;
    import __AS3__.vec.*;

    public class TreasureHuntWrapper implements IDataCenter 
    {

        public var questType:uint;
        public var checkPointCurrent:uint;
        public var checkPointTotal:uint;
        public var availableRetryCount:int;
        public var stepList:Vector.<TreasureHuntStepWrapper>;

        public function TreasureHuntWrapper()
        {
            this.stepList = new Vector.<TreasureHuntStepWrapper>();
            super();
        }

        public static function create(questType:uint, startMapId:uint, checkPointCurrent:uint, checkPointTotal:uint, availableRetryCount:int, stepList:Vector.<TreasureHuntStep>):TreasureHuntWrapper
        {
            var step:TreasureHuntStep;
            var item:TreasureHuntWrapper = new (TreasureHuntWrapper)();
            item.questType = questType;
            item.checkPointCurrent = checkPointCurrent;
            item.checkPointTotal = checkPointTotal;
            item.availableRetryCount = availableRetryCount;
            var startStep:TreasureHuntStepWrapper = TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.START, 0, startMapId, 0);
            item.stepList.push(startStep);
            for each (step in stepList)
            {
                if ((step is TreasureHuntStepFollowDirectionToPOI))
                {
                    item.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_POI, (step as TreasureHuntStepFollowDirectionToPOI).direction, 0, (step as TreasureHuntStepFollowDirectionToPOI).poiLabelId));
                };
                if ((step is TreasureHuntStepFollowDirection))
                {
                    item.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION, (step as TreasureHuntStepFollowDirection).direction, 0, 0, (step as TreasureHuntStepFollowDirection).mapCount));
                };
            };
            item.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.FIGHT, 0, 0, 0));
            return (item);
        }


        public function update(questType:uint, startMapId:uint, checkPointCurrent:uint, checkPointTotal:uint, availableRetryCount:int, stepList:Vector.<TreasureHuntStep>):void
        {
            var step:TreasureHuntStep;
            this.questType = questType;
            this.checkPointCurrent = checkPointCurrent;
            this.checkPointTotal = checkPointTotal;
            this.availableRetryCount = availableRetryCount;
            this.stepList = new Vector.<TreasureHuntStepWrapper>();
            var startStep:TreasureHuntStepWrapper = TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.START, 0, startMapId, 0);
            this.stepList.push(startStep);
            for each (step in stepList)
            {
                if ((step is TreasureHuntStepFollowDirectionToPOI))
                {
                    this.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_POI, (step as TreasureHuntStepFollowDirectionToPOI).direction, 0, (step as TreasureHuntStepFollowDirectionToPOI).poiLabelId));
                }
                else
                {
                    if ((step is TreasureHuntStepFight))
                    {
                        this.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.FIGHT, 0, 0, 0));
                    };
                };
            };
        }


    }
}//package com.ankamagames.dofus.internalDatacenter.quest

