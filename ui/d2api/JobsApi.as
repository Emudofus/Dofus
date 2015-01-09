package d2api
{
    import d2data.Job;
    import d2data.Skill;
    import d2data.Recipe;
    import d2data.KnownJob;

    public class JobsApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getKnownJobs():Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobSkills(job:Job):Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobSkillType(job:Job, skill:Skill):String
        {
            return (null);
        }

        [Untrusted]
        public function getJobCollectSkillInfos(job:Job, skill:Skill):Object
        {
            return (null);
        }

        [Untrusted]
        public function getMaxSlotsByJobId(jobId:int):int
        {
            return (0);
        }

        [Untrusted]
        public function getJobCraftSkillInfos(job:Job, skill:Skill):Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobExperience(job:Job):Object
        {
            return (null);
        }

        [Untrusted]
        public function getSkillFromId(skillId:int):Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobRecipes(job:Job, validSlotsCount:Object=null, skill:Skill=null, search:String=null):Object
        {
            return (null);
        }

        [Untrusted]
        public function getRecipe(objectId:uint):Recipe
        {
            return (null);
        }

        [Untrusted]
        public function getRecipesList(objectId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobName(pJobId:uint):String
        {
            return (null);
        }

        [Untrusted]
        public function getJob(pJobId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobCrafterDirectorySettingsById(jobId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getJobCrafterDirectorySettingsByIndex(jobIndex:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getUsableSkillsInMap(playerId:int):Object
        {
            return (null);
        }

        [Trusted]
        public function getKnownJob(jobId:uint):KnownJob
        {
            return (null);
        }

        [Untrusted]
        public function getRecipesByJob(details:Object, jobMaxSlots:Object, jobId:int=0, fromBank:Boolean=false, onlyRecipeWithXP:Boolean=false, onlyKnownJobs:Boolean=false, missingIngredientsTolerance:int=0, sortCriteria:String="level", sortDescending:Boolean=true, filterTypes:Object=null):Object
        {
            return (null);
        }

        [Untrusted]
        public function sortRecipesByCriteria(recipes:Object, sortCriteria:String, sortDescending:Boolean):Object
        {
            return (null);
        }


    }
}//package d2api

