using System.Threading.Tasks;
using JwtValidatorFirebase.Models;

namespace JwtValidatorFirebase.Interfaces
{
    public interface IJwtValidatorService
    {
        Task<string> GenerateCustomTokenAsync(string uid);

        Task<ValidatorResponse> ValidateIdTokenAsync(string rawJwt, bool useCache = true);

        int GetCacheSize();
    }
}
