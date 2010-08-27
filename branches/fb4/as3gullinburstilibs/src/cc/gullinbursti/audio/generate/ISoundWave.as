package cc.gullinbursti.audio.generate
{
	public interface ISoundWave
	{
		
		function clone(wave:ISoundWave):ISoundWave;
		function invert(wave:ISoundWave):ISoundWave;
		
		function invertSample(val:Number):Number;
		
	}
}