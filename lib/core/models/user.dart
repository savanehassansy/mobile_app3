class User {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? mobile;
  final String? resetPasswordOtp;
  final String? serial;
  final String? slug;
  final String? lang;
  final int? createdBy;
  final int? updatedBy;
  final int? lockedBy;
  final String? createdAt;
  final String? updatedAt;
  final String? lockedAt;
  final String? startedAt;
  final int? deleted;
  final int? locked;
  final int? started;
  final int? note;
  final int? verifyAccountCode;
  final String? country;
  final String? mInfo;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.mobile,
    this.resetPasswordOtp,
    this.serial,
    this.slug,
    this.lang,
    this.createdBy,
    this.updatedBy,
    this.lockedBy,
    this.createdAt,
    this.updatedAt,
    this.lockedAt,
    this.startedAt,
    this.deleted,
    this.locked,
    this.started,
    this.note,
    this.verifyAccountCode,
    this.country,
    this.mInfo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'] ?? 'Utilisateur',
      lastname: json['lastname'],
      email: json['email'],
      mobile: json['mobile'],
      resetPasswordOtp: json['reset_password_otp'],
      serial: json['serial'],
      slug: json['slug'],
      lang: json['lang'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      lockedBy: json['locked_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      lockedAt: json['locked_at'],
      startedAt: json['started_at'],
      deleted: json['deleted'],
      locked: json['locked'],
      started: json['started'],
      note: json['note'],
      verifyAccountCode: json['verify_account_code'],
      country: json['country'],
      mInfo: json['m_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'mobile': mobile,
      'reset_password_otp': resetPasswordOtp,
      'serial': serial,
      'slug': slug,
      'lang': lang,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'locked_by': lockedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'locked_at': lockedAt,
      'started_at': startedAt,
      'deleted': deleted,
      'locked': locked,
      'started': started,
      'note': note,
      'verify_account_code': verifyAccountCode,
      'country': country,
      'm_info': mInfo,
    };
  }

  Map<String, dynamic> generalInfoToJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'mobile': mobile,
      'country': country,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, firstname: $firstname, lastname: $lastname, email: $email, mobile: $mobile, resetPasswordOtp: $resetPasswordOtp, serial: $serial, slug: $slug, lang: $lang, createdBy: $createdBy, updatedBy: $updatedBy, lockedBy: $lockedBy, createdAt: $createdAt, updatedAt: $updatedAt, lockedAt: $lockedAt, startedAt: $startedAt, deleted: $deleted, locked: $locked, started: $started, note: $note, verifyAccountCode: $verifyAccountCode, country: $country, mInfo: $mInfo)';
  }

  String get fullName => '$firstname $lastname'.replaceAll("null", "");

  User copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? mobile,
    String? resetPasswordOtp,
    String? serial,
    String? slug,
    String? lang,
    int? createdBy,
    int? updatedBy,
    int? lockedBy,
    String? createdAt,
    String? updatedAt,
    String? lockedAt,
    String? startedAt,
    int? deleted,
    int? locked,
    int? started,
    int? note,
    int? verifyAccountCode,
    String? country,
    String? mInfo,
  }) {
    return User(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      resetPasswordOtp: resetPasswordOtp ?? this.resetPasswordOtp,
      serial: serial ?? this.serial,
      slug: slug ?? this.slug,
      lang: lang ?? this.lang,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      lockedBy: lockedBy ?? this.lockedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lockedAt: lockedAt ?? this.lockedAt,
      startedAt: startedAt ?? this.startedAt,
      deleted: deleted ?? this.deleted,
      locked: locked ?? this.locked,
      started: started ?? this.started,
      note: note ?? this.note,
      verifyAccountCode: verifyAccountCode ?? this.verifyAccountCode,
      country: country ?? this.country,
      mInfo: mInfo ?? this.mInfo,
    );
  }
}
