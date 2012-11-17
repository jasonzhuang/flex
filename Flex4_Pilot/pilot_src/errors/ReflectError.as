package errors
{
	public class ReflectError extends Error
	{
		public function ReflectError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}