using System;
using System.Text.Json.Serialization;
using JwtValidatorFirebase.Enums;

namespace JwtValidatorFirebase.Models
{
    public class ValidatorResponse
    {
        /// <summary>
        /// X-Hasura-User-Id
        /// </summary>
        [JsonPropertyName("X-Hasura-User-Id")]
        public string UserId { get; set; }

        /// <summary>
        /// X-Hasura-Role
        /// </summary>
        [JsonPropertyName("X-Hasura-Role")]
        public string Role { get; private set; }

        private bool _isValidated;
        /// <summary>
        /// Is token valid
        /// </summary>
        [JsonIgnore]
        public bool IsValidated
        {
            get => _isValidated;
            set
            {
                WhenValidated = DateTime.UtcNow;
                _isValidated = value;
            }
        }

        [JsonIgnore]
        public DateTime? WhenValidated { get; set; }

        public DateTime? ValidUntil { get; set; }

        public string Error { get; set; }

        public void SetRole(HasuraRoles hasuraRoles)
        {
            IsValidated = true;
            switch (hasuraRoles)
            {
                case HasuraRoles.Anonymous:
                    Role = "anonymous";
                    break;
                case HasuraRoles.User:
                    Role = "user";
                    break;
            }
        }
    }
}
