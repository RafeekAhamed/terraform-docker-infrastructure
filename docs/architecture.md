\# Architecture



\## High-Level Architecture



```text

&#x20;                        Git / GitHub

&#x20;                             |

&#x20;                             v

&#x20;                   +-------------------+

&#x20;                   |    Terraform CI   |

&#x20;                   |   GitHub Actions   |

&#x20;                   +---------+---------+

&#x20;                             |

&#x20;                             v

&#x20;                   +-------------------+

&#x20;                   |      Terraform    |

&#x20;                   |  Reusable Modules |

&#x20;                   +---------+---------+

&#x20;                             |

&#x20;             +---------------+---------------+

&#x20;             |                               |

&#x20;             v                               v

&#x20;      +-------------+                 +-------------+

&#x20;      |     DEV     |                 |    PROD     |

&#x20;      | Environment |                 | Environment |

&#x20;      +------+------+                 +------+------+

&#x20;             |                               |

&#x20;             v                               v

&#x20;  +---------------------+          +---------------------+

&#x20;  | terraform-dev-     |          | terraform-prod-    |

&#x20;  | network             |          | network             |

&#x20;  +----------+----------+          +----------+----------+

&#x20;             |                               |

&#x20;      +------+------+                  +------+------+

&#x20;      |      |      |                  |      |      |

&#x20;      v      v      v                  v      v      v

&#x20;   Nginx  Backend  PostgreSQL       Nginx  Backend  PostgreSQL

&#x20;   :8081   :5001     :5432          :8082   :5002     :5432

&#x20;      |      |      |                  |      |      |

&#x20;      +------+------+\\                +------+------+

&#x20;             |       \\                       |

&#x20;             +--------+-----------------------+

&#x20;                      |

&#x20;               Docker Networking





Module Design



The Terraform configuration is divided into reusable modules:


modules/

├── network

│   └── Creates Docker bridge network

│

├── database

│   └── Creates PostgreSQL container

│

├── backend

│   └── Builds and runs Flask application

│

└── nginx

&#x20;   └── Builds and runs Nginx reverse proxy



**Development Environment**

Browser

&#x20;  |

&#x20;  | http://localhost:8081

&#x20;  v

Nginx

terraform-dev-nginx

&#x20;  |

&#x20;  | Docker network

&#x20;  v

Backend

terraform-dev-backend

&#x20;  |

&#x20;  | PostgreSQL connection

&#x20;  v

Database

terraform-dev-postgres

**Production Environment**



Browser

&#x20;  |

&#x20;  | http://localhost:8082

&#x20;  v

Nginx

terraform-prod-nginx

&#x20;  |

&#x20;  | Docker network

&#x20;  v

Backend

terraform-prod-backend

&#x20;  |

&#x20;  | PostgreSQL connection

&#x20;  v

Database

terraform-prod-postgres

Network Isolation



Development and production use separate Docker networks:

terraform-dev-network

&#x20;       |

&#x20;       +-- terraform-dev-nginx

&#x20;       +-- terraform-dev-backend

&#x20;       +-- terraform-dev-postgres





terraform-prod-network

&#x20;       |

&#x20;       +-- terraform-prod-nginx

&#x20;       +-- terraform-prod-backend

&#x20;       +-- terraform-prod-postgres

Request Flow



A request to the development application follows:

Client

&#x20; |

&#x20; v

localhost:8081

&#x20; |

&#x20; v

Nginx :80

&#x20; |

&#x20; v

Backend :5000

&#x20; |

&#x20; v

PostgreSQL :5432

Infrastructure Lifecycle

Terraform Configuration

&#x20;       |

&#x20;       v

terraform init

&#x20;       |

&#x20;       v

terraform validate

&#x20;       |

&#x20;       v

terraform plan

&#x20;       |

&#x20;       v

terraform apply

&#x20;       |

&#x20;       v

Docker Infrastructure



CI Validation



GitHub Actions validates the Terraform configuration on repository changes:



Git Push / Pull Request

&#x20;         |

&#x20;         v

&#x20;    GitHub Actions

&#x20;         |

&#x20;         +--> terraform fmt -check

&#x20;         |

&#x20;         +--> terraform init

&#x20;         |

&#x20;         +--> terraform validate

&#x20;         |

&#x20;         v

&#x20;      CI Result





Save it.



\---



\## 3. Check everything before committing



Run:



```powershell

git status --short



