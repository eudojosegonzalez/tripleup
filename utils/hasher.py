from passlib.hash import bcrypt


def hash_password(password):
  hasher = bcrypt.using(rounds=12)
  hash = hasher.hash(password.encode("utf-8"))
  return hash

def verify_password(password, hash):
  hasher = bcrypt.using(rounds=12)
  is_valid = hasher.verify(password.encode("utf-8"), hash)
  return is_valid


def main():
  password = input("Introduce una contraseña: ")
  hash = hash_password(password)
  print("La contraseña hash es:", hash)

  password2 = input("Introduce otra contraseña: ")
  is_equal = verify_password(password2, hash)
  if is_equal:
    print("Las contraseñas son iguales")
  else:
    print("Las contraseñas son diferentes")

if __name__ == "__main__":
  main()